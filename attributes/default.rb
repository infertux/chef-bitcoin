#
# Cookbook Name:: bitcoin
# Attributes:: default
#

# common settings

default['bitcoin']['user'] = 'bitcoin'
default['bitcoin']['checkblocks'] = 288 # NOTE: this is the default, you might want to decrease it with very low-end CPUs to get fast boot time

# 'binary' recipe

default['bitcoin']['binary']['home'] = "/home/#{node['bitcoin']['user']}"
default['bitcoin']['binary']['version'] = '0.10.1'
default['bitcoin']['binary']['checksum'] = 'c1fddf6921186c6da954a977995d45a140bc07158dced004be86ddb26d9ca54d'
default['bitcoin']['binary']['service_wrapper'] = "bitcoind"
default['bitcoin']['binary']['bitcoind'] = "bin/bitcoind"
default['bitcoin']['source']['bitcoin-cli'] = node['bitcoin']['binary']['bitcoind']
default['bitcoin']['binary']['nice_level'] = 10

# 'package' recipe

default['bitcoin']['package']['repo_url']['rhel'] = 'http://linux.ringingliberty.com/bitcoin/el7/x86_64/bitcoin-release-1-6.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['rhel'] = '1d3c3984d6155a504238834a27805ca93ab598a798c6bfd54625719d46aaa969'
default['bitcoin']['package']['repo_url']['fedora'] = 'http://linux.ringingliberty.com/bitcoin/f20/x86_64/bitcoin-release-1-6.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['fedora'] = '11d6a2f28a3ae27ba040713a46ddb5b9553ea12aef7b442e9ae77a0469c3e90a'

# 'source' recipe

default['bitcoin']['source']['version'] = '0.10.1'
default['bitcoin']['source']['checksum'] = '18a88785748588bb90764dc7f0aad5548da880d4d91f5803c7076cbcadb2959e'
default['bitcoin']['source']['service_wrapper'] = "bitcoind"
default['bitcoin']['source']['home'] = "/home/#{node['bitcoin']['user']}"
default['bitcoin']['source']['prefix'] = "/usr/local"
default['bitcoin']['source']['bitcoind'] = "#{node['bitcoin']['source']['prefix']}/bin/bitcoind"
default['bitcoin']['source']['bitcoin-cli'] = "#{node['bitcoin']['source']['prefix']}/bin/bitcoin-cli"
default['bitcoin']['source']['configure_options'] = "--disable-wallet --without-gui --prefix=#{node['bitcoin']['source']['prefix']}"
default['bitcoin']['source']['make_options'] = "-j#{node['cpu']['total']}"
default['bitcoin']['source']['dependencies'] = [
  'build-essential', 'autoconf', 'libssl-dev', 'libboost-dev', 'pkg-config',
  'libboost-chrono-dev', 'libboost-filesystem-dev', 'libboost-program-options-dev',
  'libboost-system-dev', 'libboost-test-dev', 'libboost-thread-dev', 'libtool']
