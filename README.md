Bitcoin Cookbook
================

[![Funding](https://img.shields.io/liberapay/patrons/infertux.svg?logo=liberapay)](https://liberapay.com/infertux/donate)
[![Cookbook](https://img.shields.io/cookbook/v/bitcoin.svg)](https://supermarket.getchef.com/cookbooks/bitcoin)
[![Build Status](https://github.com/infertux/chef-bitcoin/actions/workflows/test.yml/badge.svg)](https://github.com/infertux/chef-bitcoin/actions)

This cookbook downloads, installs and configures Bitcoin as a full node.

Requirements
------------

### network

In order to actively contribute to the Bitcoin network, you will need to open your TCP port 8333.
This cookbook does *not* make sure your port 8333 is open since this is very much dependant on your networking setup.

Usage
-----

### `bitcoin::binary` recipe

Downloads the binary and copies it along with an systemd service unit.

### `bitcoin::source` recipe

Downloads the source code and compiles it along with an systemd service unit.

Caution: you'll need at least 1 GB of free RAM to compile it (setting `make_options` to `-j1` can help on low-end machines).

License
-------

MIT
