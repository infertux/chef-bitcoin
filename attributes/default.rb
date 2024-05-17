#
# Cookbook:: bitcoin
# Attributes:: default
#

# common settings

default['bitcoin']['variant'] = 'core' # possible variants: core

default['bitcoin']['binary_name'] = 'bitcoind'
default['bitcoin']['binary_cli_name'] = 'bitcoin-cli'
default['bitcoin']['user'] = 'bitcoin'
default['bitcoin']['home'] = "/var/lib/#{node['bitcoin']['user']}"
default['bitcoin']['conf_dir'] = "#{node['bitcoin']['home']}/.bitcoin"
default['bitcoin']['conf_file'] = "#{node['bitcoin']['conf_dir']}/bitcoin.conf"
default['bitcoin']['archive_file'] = "#{node['bitcoin']['variant']}.tar.gz"
default['bitcoin']['archive_path'] = "#{Chef::Config['file_cache_path']}/bitcoin/#{node['bitcoin']['archive_file']}"
default['bitcoin']['extract_path'] = "#{Chef::Config['file_cache_path']}/bitcoin/#{node['bitcoin']['variant']}"
default['bitcoin']['prefix'] = '/usr/local'
default['bitcoin']['binary_path'] = "#{node['bitcoin']['prefix']}/bin/#{node['bitcoin']['binary_name']}"
default['bitcoin']['binary_cli_path'] = "#{node['bitcoin']['prefix']}/bin/#{node['bitcoin']['binary_cli_name']}"

# 'binary' recipe

default['bitcoin']['binary']['version']['core']       = '27.0'
default['bitcoin']['binary']['url']['core']           = "https://bitcoincore.org/bin/bitcoin-core-#{node['bitcoin']['binary']['version']['core']}/bitcoin-#{node['bitcoin']['binary']['version']['core']}-x86_64-linux-gnu.tar.gz"
default['bitcoin']['binary']['checksum']['core']      = '2a6974c5486f528793c79d42694b5987401e4a43c97f62b1383abf35bcee44a8'

# 'source' recipe

default['bitcoin']['source']['version']['core']       = '27.0'
default['bitcoin']['source']['url']['core']           = "https://bitcoincore.org/bin/bitcoin-core-#{node['bitcoin']['binary']['version']['core']}/bitcoin-#{node['bitcoin']['source']['version']['core']}.tar.gz"
default['bitcoin']['source']['checksum']['core']      = '9c1ee651d3b157baccc3388be28b8cf3bfcefcd2493b943725ad6040ca6b146b'
default['bitcoin']['source']['dependencies']['debian'] = %w(
  build-essential libtool autotools-dev automake pkg-config bsdmainutils python3
  libevent-dev libboost-dev
)
default['bitcoin']['source']['dependencies']['freebsd'] = %w(
  autoconf automake libtool pkgconf gmake boost-all openssl
).join(' ')
default['bitcoin']['source']['configure_options'] = "--with-gui=no --disable-wallet --without-miniupnpc --disable-zmq --disable-tests --prefix=#{node['bitcoin']['prefix']}"
default['bitcoin']['source']['make_options'] = '-j $(nproc)'
