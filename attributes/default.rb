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

default['bitcoin']['binary']['version']['core']       = '0.16.0'
default['bitcoin']['binary']['version']['unlimited']  = '1.0.3.0'
default['bitcoin']['binary']['version']['bucash']     = '1.2.0.1'
default['bitcoin']['binary']['version']['abc']        = '0.17.1'
default['bitcoin']['binary']['url']['core']           = "https://bitcoin.org/bin/bitcoin-core-#{node['bitcoin']['binary']['version']['core']}/bitcoin-#{node['bitcoin']['binary']['version']['core']}-x86_64-linux-gnu.tar.gz"
default['bitcoin']['binary']['url']['unlimited']      = "https://www.bitcoinunlimited.info/downloads/bitcoinUnlimited-#{node['bitcoin']['binary']['version']['unlimited']}-linux64.tar.gz"
default['bitcoin']['binary']['url']['bucash']         = "https://www.bitcoinunlimited.info/downloads/BUcash-#{node['bitcoin']['binary']['version']['bucash']}-linux64.tar.gz"
default['bitcoin']['binary']['url']['abc']            = "https://download.bitcoinabc.org/#{node['bitcoin']['binary']['version']['abc']}/linux/bitcoin-abc-#{node['bitcoin']['binary']['version']['abc']}-x86_64-linux-gnu.tar.gz"
default['bitcoin']['binary']['checksum']['core']      = 'e6322c69bcc974a29e6a715e0ecb8799d2d21691d683eeb8fef65fc5f6a66477'
default['bitcoin']['binary']['checksum']['unlimited'] = 'a6658bac22f082539969a243943c7d1a865abd40cdfe39465ff82b4eba387b22'
default['bitcoin']['binary']['checksum']['bucash']    = '62d8e843576f6bd13fa5bc1f9b939577b63739eb99cbbd8bdec589cfdc774eb0'
default['bitcoin']['binary']['checksum']['abc']       = 'eccf8b61ba0549f6839e586c7dc6fc4bf6d7591ac432aaea8a7df0266b113d27'

# 'package' recipe

default['bitcoin']['package']['repo_url']['rhel']        = 'https://linux.ringingliberty.com/bitcoin/el7/x86_64/bitcoin-release-4-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['rhel']   = 'dcba5cb150b8af5a2c1ebec2c9d0255c8b5221c1002469f2170a679e60908ec5'
default['bitcoin']['package']['repo_url']['fedora']      = 'https://linux.ringingliberty.com/bitcoin/f27/x86_64/bitcoin-release-4-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['fedora'] = 'cac67430e1e76b1b740cd7967e0038ba7989c3fde0660a30bfd22a233e33f708'

# 'source' recipe

default['bitcoin']['source']['version']['core']       = 'v0.16.0'
default['bitcoin']['source']['version']['unlimited']  = '1.0.3.0'
default['bitcoin']['source']['version']['bucash']     = '1.2.0.1'
default['bitcoin']['source']['version']['abc']        = '0.17.1'
default['bitcoin']['source']['url']['core']           = "https://github.com/bitcoin/bitcoin/archive/#{node['bitcoin']['source']['version']['core']}.tar.gz"
default['bitcoin']['source']['url']['unlimited']      = "https://github.com/BitcoinUnlimited/BitcoinUnlimited/archive/v#{node['bitcoin']['source']['version']['unlimited']}.tar.gz"
default['bitcoin']['source']['url']['bucash']         = "https://github.com/BitcoinUnlimited/BitcoinUnlimited/archive/bucash#{node['bitcoin']['source']['version']['bucash']}.tar.gz"
default['bitcoin']['source']['url']['abc']            = "https://download.bitcoinabc.org/#{node['bitcoin']['binary']['version']['abc']}/linux/src/bitcoin-abc-#{node['bitcoin']['binary']['version']['abc']}.tar.gz"
default['bitcoin']['source']['checksum']['core']      = '8ade43e420b6aad00645d79239c21947e47f37d1f974b4948b0da0b6999c28d5'
default['bitcoin']['source']['checksum']['unlimited'] = '9c35c5391ffe5f0b0234de3133cd673729a88f96217d6e42521f6b8be9cfc533'
default['bitcoin']['source']['checksum']['bucash']    = 'fd2c09d1c306dc8d56146c961c3ea83d553168295d4a647548ca28a885fa3948'
default['bitcoin']['source']['checksum']['abc']       = '8baaedfb868fdbbde2a074b6396fb00dec28df35a0f6f29e9995778d3e08535a'
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
default['bitcoin']['source']['dependencies']['freebsd'] = %w(
  autoconf automake libtool pkgconf gmake boost-all openssl
).join(' ')
default['bitcoin']['source']['configure_options'] = "--with-gui=no --disable-wallet --without-miniupnpc --disable-zmq --disable-tests --prefix=#{node['bitcoin']['prefix']}"
default['bitcoin']['source']['make_options'] = '-j1'
