#
# Cookbook Name:: bitcoin
# Recipe:: _common
#

bitcoin_home = "#{node['bitcoin']['home']}/.bitcoin"
bitcoin_conf = "#{bitcoin_home}/bitcoin.conf"

user node['bitcoin']['user'] do
  home node['bitcoin']['home']
  shell "/bin/bash"
  supports manage_home: true
end

directory bitcoin_home do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0700"
end

template bitcoin_conf do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0600"
  action :create_if_missing
end
