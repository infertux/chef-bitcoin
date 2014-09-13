#
# Cookbook Name:: bitcoin
# Attributes:: default
#

# common settings

default['bitcoin']['user'] = 'bitcoin'
default['bitcoin']['checkblocks'] = 288 # NOTE: this is the default, you might want to decrease it with very low-end CPUs to get fast boot time


# 'binary' recipe

default['bitcoin']['binary']['home'] = '/home/bitcoin'
default['bitcoin']['binary']['version'] = '0.9.2.1'
default['bitcoin']['binary']['checksum'] = '0060f7d38b98113ab912d4c184000291d7f026eaf77ca5830deec15059678f54'
default['bitcoin']['binary']['service_wrapper'] = "bitcoind"
default['bitcoin']['binary']['bitcoind'] = "bin/bitcoind"
default['bitcoin']['binary']['nice_level'] = 10


# 'pacakge' recipe

default['bitcoin']['package']['repo_url']['rhel'] = 'http://linux.ringingliberty.com/bitcoin/el7/x86_64/bitcoin-release-1-6.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['rhel'] = '1d3c3984d6155a504238834a27805ca93ab598a798c6bfd54625719d46aaa969'

default['bitcoin']['package']['repo_url']['fedora'] = 'http://linux.ringingliberty.com/bitcoin/f20/x86_64/bitcoin-release-1-6.noarch.rpm'
default['bitcoin']['package']['repo_checksum']['fedora'] = '11d6a2f28a3ae27ba040713a46ddb5b9553ea12aef7b442e9ae77a0469c3e90a'

