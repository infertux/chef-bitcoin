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
default['bitcoin']['prefix'] = '/usr/local'
default['bitcoin']['binary_path'] = "#{node['bitcoin']['prefix']}/bin/#{node['bitcoin']['binary_name']}"
default['bitcoin']['binary_cli_path'] = "#{node['bitcoin']['prefix']}/bin/#{node['bitcoin']['binary_cli_name']}"
default['bitcoin']['checkblocks'] = 288 # NOTE: this is the default, you might want to decrease it with very low-end CPUs to get fast boot time

# 'binary' recipe

default['bitcoin']['binary']['version']['core']       = '0.16.0'
default['bitcoin']['binary']['version']['unlimited']  = '1.0.3.0'
default['bitcoin']['binary']['version']['abc']        = '0.17.0'
default['bitcoin']['binary']['url']['core']           = "https://bitcoin.org/bin/bitcoin-core-#{node['bitcoin']['binary']['version']['core']}/bitcoin-#{node['bitcoin']['binary']['version']['core']}-x86_64-linux-gnu.tar.gz"
default['bitcoin']['binary']['url']['unlimited']      = "https://www.bitcoinunlimited.info/downloads/bitcoinUnlimited-#{node['bitcoin']['binary']['version']['unlimited']}-linux64.tar.gz"
default['bitcoin']['binary']['url']['abc']            = "https://download.bitcoinabc.org/#{node['bitcoin']['binary']['version']['abc']}/linux/bitcoin-abc-#{node['bitcoin']['binary']['version']['abc']}-x86_64-linux-gnu.tar.gz"
default['bitcoin']['binary']['checksum']['core']      = 'e6322c69bcc974a29e6a715e0ecb8799d2d21691d683eeb8fef65fc5f6a66477'
default['bitcoin']['binary']['checksum']['unlimited'] = 'a6658bac22f082539969a243943c7d1a865abd40cdfe39465ff82b4eba387b22'
default['bitcoin']['binary']['checksum']['abc']       = '01dbf4981a81b1f364b21d92610832a3c8f34a93ac62e55b91c475660009a6c7'

# 'package' recipe

default['bitcoin']['package']['repo_url']['rhel']        = 'https://linux.ringingliberty.com/bitcoin/el7/x86_64/bitcoin-release-3-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['rhel']   = '450481b2ff04579ca109a90b3ce4399ea75b917b8398dc7f9baccceea7578631'
default['bitcoin']['package']['repo_url']['fedora']      = 'https://linux.ringingliberty.com/bitcoin/f23/x86_64/bitcoin-release-3-1.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['fedora'] = 'ab6f4fd8f5f7875303e6b068b1bb3e1632b1f94bb3ad900777b37f7a0b7dce46'

# 'source' recipe

default['bitcoin']['source']['version']['core']       = 'v0.16.0'
default['bitcoin']['source']['version']['unlimited']  = '1.0.3.0'
default['bitcoin']['source']['version']['abc']        = '0.17.0'
default['bitcoin']['source']['url']['core']           = "https://github.com/bitcoin/bitcoin/archive/#{node['bitcoin']['source']['version']['core']}.tar.gz"
default['bitcoin']['source']['url']['unlimited']      = "https://github.com/BitcoinUnlimited/BitcoinUnlimited/archive/v#{node['bitcoin']['source']['version']['unlimited']}.tar.gz"
default['bitcoin']['source']['url']['abc']            = "https://download.bitcoinabc.org/#{node['bitcoin']['binary']['version']['abc']}/linux/src/bitcoin-abc-#{node['bitcoin']['binary']['version']['abc']}.tar.gz"
default['bitcoin']['source']['checksum']['core']      = '8ade43e420b6aad00645d79239c21947e47f37d1f974b4948b0da0b6999c28d5'
default['bitcoin']['source']['checksum']['unlimited'] = '9c35c5391ffe5f0b0234de3133cd673729a88f96217d6e42521f6b8be9cfc533'
default['bitcoin']['source']['checksum']['abc']       = '6b9e4a666dd9900a03bd2e7ee11ff11b095284ec4deab2f9b4aa9b9e66cb1f7d'
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

# 'git' recipe

default['bitcoin']['git']['url']['btcd'] = 'https://github.com/btcsuite/btcd'
