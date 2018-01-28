#
# Cookbook Name:: bitcoin
# Attributes:: default
#

# common settings

default['bitcoin']['variant'] = nil # possible variants: core, unlimited, abc, xt

default['bitcoin']['binary_name'] = \
  case node['bitcoin']['variant']
  when 'btcd' then 'btcd'
  else 'bitcoind'
  end
default['bitcoin']['binary_cli_name'] = \
  case node['bitcoin']['variant']
  when 'btcd' then nil
  else 'bitcoin-cli'
  end

default['bitcoin']['user'] = 'bitcoin'
default['bitcoin']['home'] = "/home/#{node['bitcoin']['user']}"

default['bitcoin']['conf_dir'] = \
  case node['bitcoin']['variant']
  when 'btcd' then "#{node['bitcoin']['home']}/.btcd"
  else "#{node['bitcoin']['home']}/.bitcoin"
  end
default['bitcoin']['conf_file'] = \
  case node['bitcoin']['variant']
  when 'btcd' then "#{node['bitcoin']['conf_dir']}/btcd.conf"
  else "#{node['bitcoin']['conf_dir']}/bitcoin.conf"
  end

default['bitcoin']['service_file'] = "/usr/lib/systemd/system/#{node['bitcoin']['binary_name']}.service"
default['bitcoin']['archive_file'] = "#{node['bitcoin']['variant']}.tar.gz"
default['bitcoin']['archive_path'] = "#{Chef::Config['file_cache_path']}/bitcoin/#{node['bitcoin']['archive_file']}"
default['bitcoin']['extract_path'] = "#{Chef::Config['file_cache_path']}/bitcoin/#{node['bitcoin']['variant']}"
default['bitcoin']['prefix'] = "/usr/local"
default['bitcoin']['binary_path'] = "#{node['bitcoin']['prefix']}/bin/#{node['bitcoin']['binary_name']}"
default['bitcoin']['binary_cli_path'] = "#{node['bitcoin']['prefix']}/bin/#{node['bitcoin']['binary_cli_name']}"
default['bitcoin']['checkblocks'] = 288 # NOTE: this is the default, you might want to decrease it with very low-end CPUs to get fast boot time

# 'binary' recipe

default['bitcoin']['binary']['version']['core']       = '0.15.1'
default['bitcoin']['binary']['version']['unlimited']  = '1.0.3.0'
default['bitcoin']['binary']['version']['abc']        = '0.16.2'
default['bitcoin']['binary']['url']['core']           = "https://bitcoin.org/bin/bitcoin-core-#{node['bitcoin']['binary']['version']['core']}/bitcoin-#{node['bitcoin']['binary']['version']['core']}-x86_64-linux-gnu.tar.gz"
default['bitcoin']['binary']['url']['unlimited']      = "https://www.bitcoinunlimited.info/downloads/bitcoinUnlimited-#{node['bitcoin']['binary']['version']['unlimited']}-linux64.tar.gz"
default['bitcoin']['binary']['url']['abc']            = "https://download.bitcoinabc.org/#{node['bitcoin']['binary']['version']['abc']}/linux/bitcoin-abc-#{node['bitcoin']['binary']['version']['abc']}-x86_64-linux-gnu.tar.gz"
default['bitcoin']['binary']['checksum']['core']      = '387c2e12c67250892b0814f26a5a38f837ca8ab68c86af517f975a2a2710225b'
default['bitcoin']['binary']['checksum']['unlimited'] = 'a6658bac22f082539969a243943c7d1a865abd40cdfe39465ff82b4eba387b22'
default['bitcoin']['binary']['checksum']['abc']       = '5eeadea9c23069e08d18e0743f4a86a9774db7574197440c6d795fad5cad2084'

# 'package' recipe

default['bitcoin']['package']['repo_url']['rhel']        = 'https://linux.ringingliberty.com/bitcoin/el7/x86_64/bitcoin-release-3-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['rhel']   = '450481b2ff04579ca109a90b3ce4399ea75b917b8398dc7f9baccceea7578631'
default['bitcoin']['package']['repo_url']['fedora']      = 'https://linux.ringingliberty.com/bitcoin/f23/x86_64/bitcoin-release-3-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['fedora'] = 'ab6f4fd8f5f7875303e6b068b1bb3e1632b1f94bb3ad900777b37f7a0b7dce46'

# 'source' recipe

default['bitcoin']['source']['version']['core']       = 'v0.15.1'
default['bitcoin']['source']['version']['unlimited']  = '1.0.3.0'
default['bitcoin']['source']['version']['abc']        = '0.16.2'
default['bitcoin']['source']['url']['core']           = "https://github.com/bitcoin/bitcoin/archive/#{node['bitcoin']['source']['version']['core']}.tar.gz"
default['bitcoin']['source']['url']['unlimited']      = "https://github.com/BitcoinUnlimited/BitcoinUnlimited/archive/v#{node['bitcoin']['source']['version']['unlimited']}.tar.gz"
default['bitcoin']['source']['url']['abc']            = "https://download.bitcoinabc.org/#{node['bitcoin']['binary']['version']['abc']}/linux/src/bitcoin-abc-#{node['bitcoin']['binary']['version']['abc']}.tar.gz"
default['bitcoin']['source']['checksum']['core']      = '98b3a98a67054123bef6714e4035e18f9250a1b6d63829258ad057906e75d8b1'
default['bitcoin']['source']['checksum']['unlimited'] = '9c35c5391ffe5f0b0234de3133cd673729a88f96217d6e42521f6b8be9cfc533'
default['bitcoin']['source']['checksum']['abc']       = '71c726e24bb891ccd13c51c409844463b800afa08be8eb79f427766fc82fe1ab'
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

# 'git' recipe

default['bitcoin']['git']['url']['btcd'] = "https://github.com/btcsuite/btcd"
