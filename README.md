Bitcoin Cookbook
================
[![Cookbook](https://img.shields.io/cookbook/v/bitcoin.svg)](https://supermarket.getchef.com/cookbooks/bitcoin)
[![Build Status](https://travis-ci.org/infertux/chef-bitcoin.svg?branch=master)](https://travis-ci.org/infertux/chef-bitcoin)

This cookbook downloads, installs and configures Bitcoin Core as a full node.

Requirements
------------

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
  - supports only x86_64 architecture

### `bitcoin::binary` recipe

Downloads the official binary from https://bitcoin.org/ and copies it along with an init.d service script.

Pros:

  - official binary from https://bitcoin.org/
  - supports most distributions

Cons:

  - no SELinux support
  - supports only x86_64 architecture

### `bitcoin::source` recipe

Downloads the official release from https://github.com/bitcoin/bitcoin/releases and compiles it along with an init.d service script.

Pros:

  - official source code from https://bitcoin.org/
  - supports most distributions
  - supports ARM and other architectures

Cons:

  - no SELinux support

License
-------
MIT

