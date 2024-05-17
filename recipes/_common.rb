#
# Cookbook:: bitcoin
# Recipe:: _common
#

user node['bitcoin']['user'] do
  home node['bitcoin']['home']
  shell '/bin/sh'
  manage_home true
end

directory node['bitcoin']['conf_dir'] do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode '0700'
end

template node['bitcoin']['conf_file'] do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode '0600'
  action :create_if_missing
end
