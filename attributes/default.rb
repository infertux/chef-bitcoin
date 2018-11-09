#
# Cookbook Name:: bitcoin
# Attributes:: default
#

# common settings

default['bitcoin']['variant'] = nil # possible variants: abc, bucash, core, unlimited, xt

default['bitcoin']['binary_name'] = 'bitcoind'
default['bitcoin']['binary_cli_name'] = 'bitcoin-cli'
default['bitcoin']['user'] = 'bitcoin'
default['bitcoin']['home'] = "/home/#{node['bitcoin']['user']}"
default['bitcoin']['conf_dir'] = "#{node['bitcoin']['home']}/.bitcoin"
default['bitcoin']['conf_file'] = "#{node['bitcoin']['conf_dir']}/bitcoin.conf"
default['bitcoin']['service_file'] = "/usr/lib/systemd/system/#{node['bitcoin']['binary_name']}.service"
default['bitcoin']['archive_file'] = "#{node['bitcoin']['variant']}.tar.gz"
default['bitcoin']['archive_path'] = "#{Chef::Config['file_cache_path']}/bitcoin/#{node['bitcoin']['archive_file']}"
default['bitcoin']['extract_path'] = "#{Chef::Config['file_cache_path']}/bitcoin/#{node['bitcoin']['variant']}"
default['bitcoin']['prefix'] = '/usr/local'
default['bitcoin']['binary_path'] = "#{node['bitcoin']['prefix']}/bin/#{node['bitcoin']['binary_name']}"
default['bitcoin']['binary_cli_path'] = "#{node['bitcoin']['prefix']}/bin/#{node['bitcoin']['binary_cli_name']}"
default['bitcoin']['checkblocks'] = 288 # NOTE: this is the default, you might want to decrease it with very low-end CPUs to get fast boot time

# 'binary' recipe

default['bitcoin']['binary']['version']['core']       = '0.17.0.1'
default['bitcoin']['binary']['version']['unlimited']  = '1.0.3.0'
default['bitcoin']['binary']['version']['bucash']     = '1.5.0.1'
default['bitcoin']['binary']['version']['abc']        = '0.18.3'
default['bitcoin']['binary']['url']['core']           = "https://bitcoin.org/bin/bitcoin-core-#{node['bitcoin']['binary']['version']['core']}/bitcoin-#{node['bitcoin']['binary']['version']['core']}-x86_64-linux-gnu.tar.gz"
default['bitcoin']['binary']['url']['unlimited']      = "https://www.bitcoinunlimited.info/downloads/bitcoinUnlimited-#{node['bitcoin']['binary']['version']['unlimited']}-linux64.tar.gz"
default['bitcoin']['binary']['url']['bucash']         = "https://www.bitcoinunlimited.info/downloads/BUcash-#{node['bitcoin']['binary']['version']['bucash']}-linux64.tar.gz"
default['bitcoin']['binary']['url']['abc']            = "https://download.bitcoinabc.org/#{node['bitcoin']['binary']['version']['abc']}/linux/bitcoin-abc-#{node['bitcoin']['binary']['version']['abc']}-x86_64-linux-gnu.tar.gz"
default['bitcoin']['binary']['checksum']['core']      = '6ccc675ee91522eee5785457e922d8a155e4eb7d5524bd130eb0ef0f0c4a6008'
default['bitcoin']['binary']['checksum']['unlimited'] = 'a6658bac22f082539969a243943c7d1a865abd40cdfe39465ff82b4eba387b22'
default['bitcoin']['binary']['checksum']['bucash']    = '48b2a814f8cd53451b416a36fe1c3083cdef0a42e9329c459b39cb7daeb4c025'
default['bitcoin']['binary']['checksum']['abc']       = '0c3e858df198a7ba8fd6e457d905d56088f3928e9ac54104cfcb55fb13c29433'

# 'package' recipe

default['bitcoin']['package']['repo_url']['rhel']        = 'https://linux.ringingliberty.com/bitcoin/el7/x86_64/bitcoin-release-4-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['rhel']   = 'dcba5cb150b8af5a2c1ebec2c9d0255c8b5221c1002469f2170a679e60908ec5'
default['bitcoin']['package']['repo_url']['fedora']      = 'https://linux.ringingliberty.com/bitcoin/f27/x86_64/bitcoin-release-4-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['fedora'] = 'cac67430e1e76b1b740cd7967e0038ba7989c3fde0660a30bfd22a233e33f708'

# 'source' recipe

default['bitcoin']['source']['version']['core']       = 'v0.17.0.1'
default['bitcoin']['source']['version']['unlimited']  = '1.0.1.3'
default['bitcoin']['source']['version']['bucash']     = '1.5.0.1'
default['bitcoin']['source']['version']['abc']        = '0.18.3'
default['bitcoin']['source']['url']['core']           = "https://github.com/bitcoin/bitcoin/archive/#{node['bitcoin']['source']['version']['core']}.tar.gz"
default['bitcoin']['source']['url']['unlimited']      = "https://github.com/BitcoinUnlimited/BitcoinUnlimited/archive/#{node['bitcoin']['source']['version']['unlimited']}.tar.gz"
default['bitcoin']['source']['url']['bucash']         = "https://github.com/BitcoinUnlimited/BitcoinUnlimited/archive/bucash#{node['bitcoin']['source']['version']['bucash']}.tar.gz"
default['bitcoin']['source']['url']['abc']            = "https://github.com/Bitcoin-ABC/bitcoin-abc/archive/v#{node['bitcoin']['source']['version']['abc']}.tar.gz"
default['bitcoin']['source']['checksum']['core']      = '696353d5eaabf2f0b54522b8262fdc3197098b9a2702aac273d3a697ee7c64fa'
default['bitcoin']['source']['checksum']['unlimited'] = '50e9f948ef27d583cd411bf0925da40ee55a515ce3c7745404f6aa1de6503c06'
default['bitcoin']['source']['checksum']['bucash']    = 'f4021800bfb68dc864f4f715181fc564298c6e07b18c4ee1032fe36a1d57c2be'
default['bitcoin']['source']['checksum']['abc']       = '48db5fd2bdf2a7a719d5dec90187bcfae1becf00d808ccb895063a68344b652a'
default['bitcoin']['source']['dependencies']['debian'] = %w(
  build-essential libtool autoconf pkg-config libssl-dev libevent-dev
  libboost-system-dev libboost-filesystem-dev libboost-chrono-dev
  libboost-program-options-dev libboost-test-dev libboost-thread-dev
  libboost-system-dev libboost-test-dev libboost-thread-dev
)
default['bitcoin']['source']['dependencies']['rhel'] = %w(
  gcc-c++ libtool make file autoconf automake openssl-devel libevent-devel
  boost-devel
)
default['bitcoin']['source']['dependencies']['freebsd'] = %w(
  autoconf automake libtool pkgconf gmake boost-all openssl
).join(' ')
default['bitcoin']['source']['configure_options'] = "--with-gui=no --disable-wallet --without-miniupnpc --disable-zmq --disable-tests --prefix=#{node['bitcoin']['prefix']}"
default['bitcoin']['source']['make_options'] = '-j1'
