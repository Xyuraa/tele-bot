# Isi dari executor.sh
executor_sh =
#!/bin/bash
while true; do
  if [ -f control.txt ]; then
    CMD=$(cat control.txt)
    echo "$CMD;exit" | msfconsole -q > result.txt
    rm control.txt
  fi
  sleep 5
done
