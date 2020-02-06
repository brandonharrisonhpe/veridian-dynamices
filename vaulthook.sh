#!/bin/bash
export VAULT_ADDR="http://127.0.0.1:8200"
command=$1
shift 1
text="$@"
if [ $command = "encrypt" ]
then
  plaintext="$(base64 <<< ${text})"
  vault write -field=ciphertext transit/encrypt/orders plaintext=${plaintext}
else
  vault write -field=plaintext transit/decrypt/orders ciphertext=${text} | base64 --decode
fi
