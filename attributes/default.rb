#
# Cookbook Name:: bitcoin
# Attributes:: default
#

# common settings

default['bitcoin']['user'] = 'bitcoin'
default['bitcoin']['checkblocks'] = 288 # NOTE: this is the default, you might want to decrease it with very low-end CPUs to get fast boot time

# 'binary' recipe

default['bitcoin']['binary']['home'] = "/home/#{node['bitcoin']['user']}"
default['bitcoin']['binary']['version'] = '0.13.2'
default['bitcoin']['binary']['checksum'] = 'a3ad9ee60c9ce8b3ee804a4fe4c84518ba5871998c23ff772c1421f7c5480960'
default['bitcoin']['binary']['service_wrapper'] = "bitcoind"
default['bitcoin']['binary']['bitcoind'] = "bin/bitcoind"
default['bitcoin']['binary']['bitcoin-cli'] = node['bitcoin']['binary']['bitcoind']
default['bitcoin']['binary']['nice_level'] = 10

# 'package' recipe

default['bitcoin']['package']['repo_url']['rhel'] = 'https://linux.ringingliberty.com/bitcoin/el7/x86_64/bitcoin-release-3-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['rhel'] = '450481b2ff04579ca109a90b3ce4399ea75b917b8398dc7f9baccceea7578631'
default['bitcoin']['package']['repo_url']['fedora'] = 'https://linux.ringingliberty.com/bitcoin/f23/x86_64/bitcoin-release-3-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['fedora'] = 'ab6f4fd8f5f7875303e6b068b1bb3e1632b1f94bb3ad900777b37f7a0b7dce46'
default['bitcoin']['package']['variant'] = 'core' # possible variants: core, classic, xt

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
