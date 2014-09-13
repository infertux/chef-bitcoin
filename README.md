Bitcoin Cookbook
================
[![Cookbook](https://img.shields.io/cookbook/v/bitcoin.svg)](https://github.com/infertux/chef-bitcoin)
[![Build Status](https://travis-ci.org/infertux/chef-bitcoin.svg?branch=master)](https://travis-ci.org/infertux/chef-bitcoin)

This cookbook downloads, installs and configures Bitcoin Core as a full node.

Requirements
------------

### platforms
Note that it only works on x86_64 architectures at the moment.

### network
In order to actively contribute to the Bitcoin network, you will need to open your TCP port 8333.
This cookbook does *not* make sure your port 8333 is open since this is very much dependant on your networking setup.

Usage
-----

### `bitcoin::package` recipe

Configures repository from http://www.ringingliberty.com/bitcoin/ and installs pre-packaged binary with `bitcoin` systemd service.

Pros:

  - proper packaging
  - SELinux support

Cons:

  - supports only RHEL, CentOS and Fedora for now

### `bitcoin::binary` recipe

Downloads the official binary from https://bitcoin.org/ and copies it along with a wrapper script to start, stop, restart and get the status of `bitcoind`.

Pros:

  - official binary from https://bitcoin.org/
  - supports most distributions

Cons:

  - no SELinux support
  - no init.d/systemd-like script to manage `bitcoind` as a Unix service

License
-------
MIT

