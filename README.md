Bitcoin Cookbook
================

This cookbook downloads, installs and configures Bitcoin Core as a full node.

Requirements
------------

### platforms
This should work on any decent Linux distribution (tested on RHEL and Debian families so far).
Note that it only works on x86_64 architectures at the moment.

### network
In order to actively contribute to the Bitcoin network, you will need to open your port TCP 8333.
This cookbook does *not* make sure your port 8333 is open since this is very much dependant on your networking setup.

Usage
-----

Just include `bitcoin` in your node's `run_list` to spread the love:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[bitcoin]"
  ]
}
```

License
-------
MIT

