#
# Cookbook Name:: bitcoin
# Attributes:: default
#

# common settings

default['bitcoin']['user'] = 'bitcoin'
default['bitcoin']['home'] = "/home/#{node['bitcoin']['user']}"
default['bitcoin']['checkblocks'] = 288 # NOTE: this is the default, you might want to decrease it with very low-end CPUs to get fast boot time

# 'binary' recipe

default['bitcoin']['binary']['version'] = '0.13.2'
default['bitcoin']['binary']['checksum'] = 'a3ad9ee60c9ce8b3ee804a4fe4c84518ba5871998c23ff772c1421f7c5480960'
default['bitcoin']['binary']['bitcoind'] = "bin/bitcoind"
default['bitcoin']['binary']['bitcoin-cli'] = node['bitcoin']['binary']['bitcoind']
default['bitcoin']['binary']['nice_level'] = 10

# 'package' recipe

default['bitcoin']['package']['variant'] = 'core' # possible variants: core, classic, xt
default['bitcoin']['package']['repo_url']['rhel'] = 'https://linux.ringingliberty.com/bitcoin/el7/x86_64/bitcoin-release-3-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['rhel'] = '450481b2ff04579ca109a90b3ce4399ea75b917b8398dc7f9baccceea7578631'
default['bitcoin']['package']['repo_url']['fedora'] = 'https://linux.ringingliberty.com/bitcoin/f23/x86_64/bitcoin-release-3-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['fedora'] = 'ab6f4fd8f5f7875303e6b068b1bb3e1632b1f94bb3ad900777b37f7a0b7dce46'

# 'source' recipe

default['bitcoin']['source']['variant'] = 'core' # possible variants: core, unlimited
default['bitcoin']['source']['prefix'] = "/usr/local"
default['bitcoin']['source']['bitcoind'] = "#{node['bitcoin']['source']['prefix']}/bin/bitcoind"
default['bitcoin']['source']['bitcoin-cli'] = "#{node['bitcoin']['source']['prefix']}/bin/bitcoin-cli"
default['bitcoin']['source']['configure_options'] = "--with-gui=no --disable-wallet --without-miniupnpc --disable-zmq --prefix=#{node['bitcoin']['source']['prefix']}"
default['bitcoin']['source']['make_options'] = "-j1"

default['bitcoin']['source']['core']['version']        = '0.13.2'
default['bitcoin']['source']['unlimited']['version']   = '0.13.2rc1'
default['bitcoin']['source']['core']['url']            = "https://github.com/bitcoin/bitcoin/archive/v#{node['bitcoin']['source']['core']['version']}.tar.gz"
default['bitcoin']['source']['unlimited']['url']       = "https://github.com/BitcoinUnlimited/BitcoinUnlimited/archive/v#{node['bitcoin']['source']['unlimited']['version']}.tar.gz"
default['bitcoin']['source']['core']['checksum']       = 'a3ad9ee60c9ce8b3ee804a4fe4c84518ba5871998c23ff772c1421f7c5480960'
default['bitcoin']['source']['unlimited']['checksum']  = '66c5e0d3883123743a76f76e8aef126fedff14df345a0557b91d687657a7dfc2'
default['bitcoin']['source']['dependencies']['debian'] = %w(
  build-essential autoconf libssl-dev pkg-config libtool
  libboost-system-dev libboost-filesystem-dev libboost-chrono-dev
  libboost-program-options-dev libboost-test-dev libboost-thread-dev
  libboost-system-dev libboost-test-dev libboost-thread-dev
)
default['bitcoin']['source']['dependencies']['rhel'] = %w(
  gcc-c++ libtool make autoconf automake openssl-devel libevent-devel
  boost-devel libdb4-devel libdb4-cxx-devel
)
