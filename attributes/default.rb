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

default['bitcoin']['binary']['version']['core']       = '0.14.2'
default['bitcoin']['binary']['version']['unlimited']  = '1.0.3.0'
default['bitcoin']['binary']['version']['classic']    = '1.3.6'
default['bitcoin']['binary']['version']['abc']        = '0.15.0'
default['bitcoin']['binary']['url']['core']           = "https://bitcoin.org/bin/bitcoin-core-#{node['bitcoin']['binary']['version']['core']}/bitcoin-#{node['bitcoin']['binary']['version']['core']}-x86_64-linux-gnu.tar.gz"
default['bitcoin']['binary']['url']['unlimited']      = "https://www.bitcoinunlimited.info/downloads/bitcoinUnlimited-#{node['bitcoin']['binary']['version']['unlimited']}-linux64.tar.gz"
default['bitcoin']['binary']['url']['classic']        = "https://github.com/bitcoinclassic/bitcoinclassic/releases/download/v#{node['bitcoin']['binary']['version']['classic']}/bitcoin-#{node['bitcoin']['binary']['version']['classic']}-linux64.tar.gz"
default['bitcoin']['binary']['url']['abc']            = "https://download.bitcoinabc.org/#{node['bitcoin']['binary']['version']['abc']}/linux/bitcoin-abc-#{node['bitcoin']['binary']['version']['abc']}-x86_64-linux-gnu.tar.gz"
default['bitcoin']['binary']['checksum']['core']      = '20acc6d5d5e0c4140387bc3445b8b3244d74c1c509bd98f62b4ee63bec31a92b'
default['bitcoin']['binary']['checksum']['unlimited'] = 'a6658bac22f082539969a243943c7d1a865abd40cdfe39465ff82b4eba387b22'
default['bitcoin']['binary']['checksum']['classic']   = '311c636f400d84b1bc615f6c1a1b48837d1dd04bd78615a7e0b7bd3c86d53aea'
default['bitcoin']['binary']['checksum']['abc']       = 'de8ec283d6d3bb15545b39dc07f3207d7502d51dd98cfeac79e8d78462808cfc'

# 'package' recipe

default['bitcoin']['package']['repo_url']['rhel']        = 'https://linux.ringingliberty.com/bitcoin/el7/x86_64/bitcoin-release-3-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['rhel']   = '450481b2ff04579ca109a90b3ce4399ea75b917b8398dc7f9baccceea7578631'
default['bitcoin']['package']['repo_url']['fedora']      = 'https://linux.ringingliberty.com/bitcoin/f23/x86_64/bitcoin-release-3-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['fedora'] = 'ab6f4fd8f5f7875303e6b068b1bb3e1632b1f94bb3ad900777b37f7a0b7dce46'

# 'source' recipe

default['bitcoin']['source']['version']['core']       = 'v0.14.2'
default['bitcoin']['source']['version']['unlimited']  = '1.0.3.0'
default['bitcoin']['source']['version']['classic']    = '1.3.6'
default['bitcoin']['source']['version']['abc']        = '0.15.0'
default['bitcoin']['source']['url']['core']           = "https://github.com/bitcoin/bitcoin/archive/#{node['bitcoin']['source']['version']['core']}.tar.gz"
default['bitcoin']['source']['url']['unlimited']      = "https://github.com/BitcoinUnlimited/BitcoinUnlimited/archive/v#{node['bitcoin']['source']['version']['unlimited']}.tar.gz"
default['bitcoin']['source']['url']['classic']        = "https://github.com/bitcoinclassic/bitcoinclassic/archive/v#{node['bitcoin']['source']['version']['classic']}.tar.gz"
default['bitcoin']['source']['url']['abc']            = "https://download.bitcoinabc.org/#{node['bitcoin']['binary']['version']['abc']}/linux/src/bitcoin-abc-#{node['bitcoin']['binary']['version']['abc']}.tar.gz"
default['bitcoin']['source']['checksum']['core']      = 'e0ac23f01a953fcc6290c96799deeffb32aa76ca8e216c564d20c18e75a25219'
default['bitcoin']['source']['checksum']['unlimited'] = '27f4d0b6c2148aefd981479f15d950f58709a42639a9ebf8cefee80b6a82ec0a'
default['bitcoin']['source']['checksum']['classic']   = 'b5ad0706ce62fd75fd16c0c1c019b1e2e644143b92f1a80542f0c84da0d33cf6'
default['bitcoin']['source']['checksum']['abc']       = 'ae1efb25068fa6ae910650b3d84a308e395d55264e95dc6d7f1d2e939bc9219f'
default['bitcoin']['source']['dependencies']['debian'] = %w[
  build-essential libtool autoconf pkg-config libssl-dev libevent-dev
  libboost-system-dev libboost-filesystem-dev libboost-chrono-dev
  libboost-program-options-dev libboost-test-dev libboost-thread-dev
  libboost-system-dev libboost-test-dev libboost-thread-dev
]
default['bitcoin']['source']['dependencies']['rhel'] = %w[
  gcc-c++ libtool make autoconf automake openssl-devel libevent-devel
  boost-devel
]
default['bitcoin']['source']['dependencies']['freebsd'] = %w[
  autoconf automake libtool pkgconf gmake boost-all openssl
].join(' ')
default['bitcoin']['source']['configure_options'] = "--with-gui=no --disable-wallet --without-miniupnpc --disable-zmq --disable-tests --prefix=#{node['bitcoin']['prefix']}"
default['bitcoin']['source']['make_options'] = '-j1'
