#
# Cookbook Name:: bitcoin
# Attributes:: default
#

default['bitcoin']['version'] = '0.9.2.1'
default['bitcoin']['checksum'] = '0060f7d38b98113ab912d4c184000291d7f026eaf77ca5830deec15059678f54'

default['bitcoin']['user'] = 'bitcoin'
default['bitcoin']['home'] = '/home/bitcoin'

default['bitcoin']['service_wrapper'] = "bitcoind"
default['bitcoin']['binary'] = "bin/bitcoind"
default['bitcoin']['nice_level'] = 10
default['bitcoin']['checkblocks'] = 288 # NOTE: this is the default, you might want to decrease it with very low-end CPUs to get fast boot time

