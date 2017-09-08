Bitcoin Cookbook
================
[![Cookbook](https://img.shields.io/cookbook/v/bitcoin.svg)](https://supermarket.getchef.com/cookbooks/bitcoin)
[![Build Status](https://travis-ci.org/infertux/chef-bitcoin.svg?branch=master)](https://travis-ci.org/infertux/chef-bitcoin)

This cookbook downloads, installs and configures Bitcoin as a full node.

Requirements
------------

### network
In order to actively contribute to the Bitcoin network, you will need to open your TCP port 8333.
This cookbook does *not* make sure your port 8333 is open since this is very much dependant on your networking setup.

Usage
-----

### Comparison table

| recipe:                             | package                | binary                              | source                              |
| :---                                | :---:                  | :---:                               | :---:                               |
| support most distributions          | only RHEL & CentOS     | **yes**                             | **yes**                             |
| support ARM and other architectures | only x86_64            | only x86_64                         | **yes**                             |
| variants available                  | Core, Classic & XT     | **Core, Unlimited, Classic & ABC**  | **Core, Unlimited, Classic & ABC**  |
| proper packaging                    | **yes**                | no                                  | no                                  |
| SELinux support                     | **yes**                | no                                  | no                                  |

The matrix of available configurations can be found [there](https://travis-ci.org/infertux/chef-bitcoin).

### `bitcoin::package` recipe

Configures repository from http://www.ringingliberty.com/bitcoin/ and installs pre-packaged binary with `bitcoin` systemd service.

You can run a Bitcoin fork/variant like this:

```
    "bitcoin": {
      "variant": "unlimited"
    }
```

The valid variants are `core`, `unlimited`, `classic`, `abc` and `xt`.

### `bitcoin::binary` recipe

Downloads the binary and copies it along with an systemd service script.

### `bitcoin::source` recipe

Downloads the release from GitHub and compiles it along with an systemd service script.

Caution: you'll need at least 1 GB of free RAM to compile it (setting `make_options` to `-j1` can help too).

License
-------
MIT
