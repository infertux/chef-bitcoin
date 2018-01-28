#!/usr/bin/env bats

@test "bitcoind binary is found in PATH" {
  [ -f /home/bitcoin/go/bin/btcd ] && skip "btcd found"

  run which bitcoind
  [ "$status" -eq 0 ]
}

@test "bitcoin-cli binary is found in PATH" {
  [ -f /home/bitcoin/go/bin/btcctl ] && skip "btcctl found"

  run which bitcoin-cli
  [ "$status" -eq 0 ]
}
