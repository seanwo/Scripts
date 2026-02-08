#!/usr/bin/env bash
set -euo pipefail

cmd="${1:-}"
bridge="${2:-bridge100}"
dns="${3:-1.1.1.1}"
anchor="com.apple.internet-sharing"

case "$cmd" in
  on)
    utun="$(netstat -rn | awk '/^0\/1|^128\.0\/1/ {print $NF; exit}')"
    ip="$(ifconfig "$bridge" | awk '/inet /{print $2; exit}')"
    subnet="${ip%.*}.0/24"

    sudo pfctl -E >/dev/null 2>&1 || true
    sudo pfctl -a "$anchor" -f - <<PF
nat on $utun from $subnet to any -> ($utun)
rdr pass on $bridge inet proto udp from any to any port 53 -> $dns port 53
PF
    ;;
  off)
    sudo pfctl -a "$anchor" -F all >/dev/null 2>&1 || true
    sudo pfctl -d >/dev/null 2>&1 || true
    ;;
  *)
    echo "Usage: $0 on|off [bridge_if] [dns_ip]"
    exit 1
    ;;
esac
