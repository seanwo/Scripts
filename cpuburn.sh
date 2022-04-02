#!/bin/bash
CPU=$(sysctl -n hw.ncpu)
seq $CPU | xargs -I{} -P $CPU yes > /dev/null
