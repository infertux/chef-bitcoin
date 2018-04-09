#!/usr/bin/env bats

@test "bitcoind binary is found in PATH" {
  run which bitcoind
  [ "$status" -eq 0 ]
}

@test "bitcoin-cli binary is found in PATH" {
  run which bitcoin-cli
  [ "$status" -eq 0 ]
}
