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

default['bitcoin']['binary']['version']['core']       = '0.17.1'
default['bitcoin']['binary']['version']['unlimited']  = '1.0.3.0'
default['bitcoin']['binary']['version']['bucash']     = '1.5.1.0'
default['bitcoin']['binary']['version']['abc']        = '0.18.5'
default['bitcoin']['binary']['url']['core']           = "https://bitcoin.org/bin/bitcoin-core-#{node['bitcoin']['binary']['version']['core']}/bitcoin-#{node['bitcoin']['binary']['version']['core']}-x86_64-linux-gnu.tar.gz"
default['bitcoin']['binary']['url']['unlimited']      = "https://www.bitcoinunlimited.info/downloads/bitcoinUnlimited-#{node['bitcoin']['binary']['version']['unlimited']}-linux64.tar.gz"
default['bitcoin']['binary']['url']['bucash']         = "https://www.bitcoinunlimited.info/downloads/BUcash-#{node['bitcoin']['binary']['version']['bucash']}-linux64.tar.gz"
default['bitcoin']['binary']['url']['abc']            = "https://download.bitcoinabc.org/#{node['bitcoin']['binary']['version']['abc']}/linux/bitcoin-abc-#{node['bitcoin']['binary']['version']['abc']}-x86_64-linux-gnu.tar.gz"
default['bitcoin']['binary']['checksum']['core']      = '53ffca45809127c9ba33ce0080558634101ec49de5224b2998c489b6d0fc2b17'
default['bitcoin']['binary']['checksum']['unlimited'] = 'a6658bac22f082539969a243943c7d1a865abd40cdfe39465ff82b4eba387b22'
default['bitcoin']['binary']['checksum']['bucash']    = 'c3a59b79e46a09ea2a3575ac8b1e9f098274084b676fba3e717346916f3e2a8d'
default['bitcoin']['binary']['checksum']['abc']       = '11439fcdae421ae96d2a7ddc3d43c9c284af44716cb5f363c61e53885a5a8811'

# 'package' recipe

default['bitcoin']['package']['repo_url']['rhel']        = 'https://linux.ringingliberty.com/bitcoin/el7/x86_64/bitcoin-release-4-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['rhel']   = 'dcba5cb150b8af5a2c1ebec2c9d0255c8b5221c1002469f2170a679e60908ec5'
default['bitcoin']['package']['repo_url']['fedora']      = 'https://linux.ringingliberty.com/bitcoin/f27/x86_64/bitcoin-release-4-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['fedora'] = 'cac67430e1e76b1b740cd7967e0038ba7989c3fde0660a30bfd22a233e33f708'

# 'source' recipe

default['bitcoin']['source']['version']['core']       = 'v0.17.1'
default['bitcoin']['source']['version']['unlimited']  = '1.0.1.3'
default['bitcoin']['source']['version']['bucash']     = '1.5.1.0'
default['bitcoin']['source']['version']['abc']        = '0.18.5'
default['bitcoin']['source']['url']['core']           = "https://github.com/bitcoin/bitcoin/archive/#{node['bitcoin']['source']['version']['core']}.tar.gz"
default['bitcoin']['source']['url']['unlimited']      = "https://github.com/BitcoinUnlimited/BitcoinUnlimited/archive/#{node['bitcoin']['source']['version']['unlimited']}.tar.gz"
default['bitcoin']['source']['url']['bucash']         = "https://github.com/BitcoinUnlimited/BitcoinUnlimited/archive/bucash#{node['bitcoin']['source']['version']['bucash']}.tar.gz"
default['bitcoin']['source']['url']['abc']            = "https://github.com/Bitcoin-ABC/bitcoin-abc/archive/v#{node['bitcoin']['source']['version']['abc']}.tar.gz"
default['bitcoin']['source']['checksum']['core']      = 'd51bae80fc0a460ce752d04097c4a1271a66b55260d53165d82313488117d290'
default['bitcoin']['source']['checksum']['unlimited'] = '50e9f948ef27d583cd411bf0925da40ee55a515ce3c7745404f6aa1de6503c06'
default['bitcoin']['source']['checksum']['bucash']    = '0c10b7b0165ddef557734ffe52cb2036226e94a3c7c92573af58638916f610d2'
default['bitcoin']['source']['checksum']['abc']       = 'd2a3ee6d25f626ecaf991b38635ced26f913edbb531ce289f16ccabda257db9e'
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
