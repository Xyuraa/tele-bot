#!/bin/bash
while true; do
  if [ -f control.txt ]; then
    CMD=$(cat control.txt)
    echo "[*] Menjalankan perintah: $CMD"
    echo "run meterpreter script: $CMD" > result.txt
    rm control.txt
  fi
  sleep 5
done
