#
# Cookbook Name:: bitcoin
# Attributes:: default
#

# common settings

default['bitcoin']['variant'] = 'core' # possible variants: core, unlimited, classic, xt
default['bitcoin']['user'] = 'bitcoin'
default['bitcoin']['home'] = "/home/#{node['bitcoin']['user']}"
default['bitcoin']['conf_dir'] = "#{node['bitcoin']['home']}/.bitcoin"
default['bitcoin']['conf_file'] = "#{node['bitcoin']['conf_dir']}/bitcoin.conf"
default['bitcoin']['service_file'] = "/usr/lib/systemd/system/bitcoind.service"
default['bitcoin']['archive_file'] = "#{node['bitcoin']['variant']}.tar.gz"
default['bitcoin']['archive_path'] = "#{Chef::Config['file_cache_path']}/bitcoin/#{node['bitcoin']['archive_file']}"
default['bitcoin']['extract_path'] = "#{Chef::Config['file_cache_path']}/bitcoin/#{node['bitcoin']['variant']}"
default['bitcoin']['prefix'] = "/usr/local"
default['bitcoin']['bitcoind'] = "#{node['bitcoin']['prefix']}/bin/bitcoind"
default['bitcoin']['bitcoin_cli'] = "#{node['bitcoin']['prefix']}/bin/bitcoin-cli"
default['bitcoin']['checkblocks'] = 288 # NOTE: this is the default, you might want to decrease it with very low-end CPUs to get fast boot time

# 'binary' recipe

default['bitcoin']['binary']['version']['core']       = '0.13.2'
default['bitcoin']['binary']['url']['core']           = "https://bitcoin.org/bin/bitcoin-core-#{node['bitcoin']['binary']['version']['core']}/bitcoin-#{node['bitcoin']['binary']['version']['core']}-x86_64-linux-gnu.tar.gz"
default['bitcoin']['binary']['version']['unlimited']  = '1.0.0'
default['bitcoin']['binary']['url']['unlimited']      = "https://www.bitcoinunlimited.info/downloads/bitcoinUnlimited-#{node['bitcoin']['binary']['version']['unlimited']}-linux64.tar.gz"
default['bitcoin']['binary']['checksum']['core']      = '29215a7fe7430224da52fc257686d2d387546eb8acd573a949128696e8761149'
default['bitcoin']['binary']['checksum']['unlimited'] = '65b2061c7de35afa2f094f27aa48ef6c5a75a54ea0516948303a04c65ecbc2d5'

# 'package' recipe

default['bitcoin']['package']['repo_url']['rhel']        = 'https://linux.ringingliberty.com/bitcoin/el7/x86_64/bitcoin-release-3-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['rhel']   = '450481b2ff04579ca109a90b3ce4399ea75b917b8398dc7f9baccceea7578631'
default['bitcoin']['package']['repo_url']['fedora']      = 'https://linux.ringingliberty.com/bitcoin/f23/x86_64/bitcoin-release-3-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['fedora'] = 'ab6f4fd8f5f7875303e6b068b1bb3e1632b1f94bb3ad900777b37f7a0b7dce46'

# 'source' recipe

default['bitcoin']['source']['version']['core']       = 'v0.13.2'
default['bitcoin']['source']['version']['unlimited']  = '1.0.0'
default['bitcoin']['source']['url']['core']           = "https://github.com/bitcoin/bitcoin/archive/#{node['bitcoin']['source']['version']['core']}.tar.gz"
default['bitcoin']['source']['url']['unlimited']      = "https://github.com/BitcoinUnlimited/BitcoinUnlimited/archive/#{node['bitcoin']['source']['version']['unlimited']}.tar.gz"
default['bitcoin']['source']['checksum']['core']      = '8a1307605b71b1df720ed0360d801d8939138aaca0a495d0f1e4e500efc2eaa1'
default['bitcoin']['source']['checksum']['unlimited'] = '69f7f65a5f4a5a6539228a6fc09af11af3dfb6d91ea866d29bd7065824b6cbb6'
default['bitcoin']['source']['dependencies']['debian'] = %w(
  build-essential libtool autoconf pkg-config libssl-dev libevent-dev
  libboost-system-dev libboost-filesystem-dev libboost-chrono-dev
  libboost-program-options-dev libboost-test-dev libboost-thread-dev
  libboost-system-dev libboost-test-dev libboost-thread-dev
)
default['bitcoin']['source']['dependencies']['rhel'] = %w(
  gcc-c++ libtool make autoconf automake openssl-devel libevent-devel
  boost-devel
)
default['bitcoin']['source']['configure_options'] = "--with-gui=no --disable-wallet --without-miniupnpc --disable-zmq --disable-tests --prefix=#{node['bitcoin']['prefix']}"
default['bitcoin']['source']['make_options'] = "-j#{node['cpu']['total']}"
