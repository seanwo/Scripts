#!/usr/bin/env bash
set -euo pipefail

# === Config (override via env) ===
MODELS_DIR="${MODELS_DIR:-$HOME/whisper-models}"
VAD_DIR="${VAD_DIR:-$HOME/whisper-vad}"
RNNOISE_DIR="${RNNOISE_DIR:-$HOME/rnnoise-models}"
WHISPER_MODEL="${WHISPER_MODEL:-$MODELS_DIR/ggml-large-v3.bin}"
VAD_MODEL="${VAD_MODEL:-$VAD_DIR/silero-v5.1.2-ggml.bin}"
RNNOISE_MODEL="${RNNOISE_MODEL:-$RNNOISE_DIR/somnolent-hogwash-2018-09-01/sh.rnnn}"
AUDIO_RATE=16000
AUDIO_CH=1
AAC_BR="160k"
THREADS="${THREADS:-$(sysctl -n hw.ncpu 2>/dev/null || echo 8)}"
KEEP_INTERMEDIATES=0  # set to 1 or pass -k to keep

usage() {
  cat <<EOF
Usage: $0 [-k] /path/to/original.mp4

Options:
  -k     Keep intermediates (input.mp4, audio.wav, audio.wav.srt)

Environment overrides:
  MODELS_DIR, VAD_DIR, RNNOISE_DIR, WHISPER_MODEL, VAD_MODEL, RNNOISE_MODEL,
  AUDIO_RATE, AUDIO_CH, AAC_BR, THREADS
EOF
  exit 1
}

# Parse flags
while getopts ":k" opt; do
  case "$opt" in
    k) KEEP_INTERMEDIATES=1 ;;
    *) usage ;;
  esac
done
shift $((OPTIND - 1))

# Arg check
[[ $# -eq 1 ]] || usage
ORIG_MP4="$1"
[[ -f "$ORIG_MP4" ]] || { echo "ERROR: File not found: $ORIG_MP4" >&2; exit 2; }

# Paths & filenames
ORIG_DIR="$(cd "$(dirname "$ORIG_MP4")" && pwd)"
BASENAME="$(basename "$ORIG_MP4")"
STEM="${BASENAME%.*}"

WORKDIR="$ORIG_DIR"
INPUT_MP4="$WORKDIR/input.mp4"
AUDIO_WAV="$WORKDIR/audio.wav"
SRT_FILE="$AUDIO_WAV.srt"
OUTPUT_MP4="$WORKDIR/${STEM}.with-subs.mp4"

# Cleanup on error unless keeping
cleanup() {
  if [[ $KEEP_INTERMEDIATES -eq 0 ]]; then
    rm -f "$INPUT_MP4" "$AUDIO_WAV" "$SRT_FILE"
  fi
}
trap cleanup EXIT

# --- Dependency checks --------------------------------------------------------
need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

echo "== Checking dependencies =="

if ! need_cmd brew; then
  echo "ERROR: Homebrew not found. Install from https://brew.sh then re-run." >&2
  exit 3
fi

# Show (and optionally suggest) installs; do NOT auto-install silently
for cmd in ffmpeg whisper-cli curl tar; do
  if ! need_cmd "$cmd"; then
    case "$cmd" in
      ffmpeg) echo "Missing 'ffmpeg'. Install with: brew install ffmpeg" ;;
      whisper-cli) echo "Missing 'whisper-cli'. Install with: brew install whisper-cpp" ;;
      curl) echo "Missing 'curl'. Install with: brew install curl (or enable macOS curl)" ;;
      tar) echo "Missing 'tar'. (Should be on macOS by default.)" ;;
    esac
    MISSING=1
  fi
done

if [[ "${MISSING:-0}" -eq 1 ]]; then
  echo "Please install the missing dependencies above and re-run." >&2
  exit 4
fi

# --- Ensure model files -------------------------------------------------------
echo "== Ensuring model files =="

# Whisper models
mkdir -p "$MODELS_DIR"
if [[ ! -f "$MODELS_DIR/ggml-medium.bin" ]]; then
  echo "Downloading ggml-medium.bin ..."
  curl -L -o "$MODELS_DIR/ggml-medium.bin" \
    "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-medium.bin"
fi
if [[ ! -f "$WHISPER_MODEL" ]]; then
  echo "Downloading ggml-large-v3.bin ..."
  curl -L -o "$WHISPER_MODEL" \
    "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3.bin"
fi

# VAD model
mkdir -p "$VAD_DIR"
if [[ ! -f "$VAD_MODEL" ]]; then
  echo "Downloading silero VAD model ..."
  curl -fL -o "$VAD_MODEL" \
    "https://huggingface.co/ggml-org/whisper-vad/resolve/main/ggml-silero-v5.1.2.bin"
fi

# RNNoise models
mkdir -p "$RNNOISE_DIR"
if [[ ! -f "$RNNOISE_MODEL" ]]; then
  echo "Fetching rnnoise-nu model pack ..."
  curl -L "https://github.com/GregorR/rnnoise-models/archive/refs/heads/master.tar.gz" \
    | tar -xz -C "$RNNOISE_DIR" --strip-components=1
  if [[ ! -f "$RNNOISE_MODEL" ]]; then
    echo "ERROR: Expected rnnoise model not found at $RNNOISE_MODEL" >&2
    echo "Check contents of $RNNOISE_DIR or adjust RNNOISE_MODEL env var." >&2
    exit 5
  fi
fi

# --- Workflow ----------------------------------------------------------------
echo "== Remuxing video safely =="
ffmpeg -y -i "$ORIG_MP4" \
  -c:v copy -c:a aac -b:a "$AAC_BR" -ar 48000 \
  -movflags +faststart \
  "$INPUT_MP4"

echo "== Extracting + denoising audio for subtitles =="
ffmpeg -y -i "$INPUT_MP4" -map 0:a:0 -vn \
  -ac "$AUDIO_CH" -ar "$AUDIO_RATE" \
  -af "arnndn=m=${RNNOISE_MODEL}" \
  -c:a pcm_s16le \
  "$AUDIO_WAV"

echo "== Generating English subtitles from Danish audio with Whisper =="
# Notes:
#  -l da       : source language Danish
#  --translate : translate to English
#  --vad and --vad-model: better segmentation with Silero VAD
#  -t          : threads
#  -bs/-bo     : batch size / beam options (as provided)
whisper-cli \
  -m "$WHISPER_MODEL" \
  -f "$AUDIO_WAV" \
  -l da \
  --translate \
  -osrt \
  -t "$THREADS" \
  -bs 5 -bo 2 \
  --vad \
  --vad-model "$VAD_MODEL" \
  -et 3.0 -lpt -0.5

if [[ ! -f "$SRT_FILE" ]]; then
  echo "ERROR: Subtitle file not produced: $SRT_FILE" >&2
  exit 6
fi

echo "== Muxing subtitles back into MP4 (mov_text) =="
ffmpeg -y -i "$INPUT_MP4" -i "$SRT_FILE" \
  -c copy \
  -c:s mov_text \
  -metadata:s:s:0 language=eng \
  "$OUTPUT_MP4"

echo "✅ Done: $OUTPUT_MP4"
if [[ $KEEP_INTERMEDIATES -eq 1 ]]; then
  echo "Intermediates kept:"
  echo "  $INPUT_MP4"
  echo "  $AUDIO_WAV"
  echo "  $SRT_FILE"
fi