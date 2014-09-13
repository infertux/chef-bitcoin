#
# Cookbook Name:: bitcoin
# Recipe:: default
#

%w(start stop restart status).each do |service_action|

  execute "bitcoind #{service_action}" do
    cwd node['bitcoin']['home']
    command %{su - #{node['bitcoin']['user']} -c './#{node['bitcoin']['service_wrapper']} #{service_action}'}
    action :nothing
  end

end

user node['bitcoin']['user'] do
  home node['bitcoin']['home']
  shell "/bin/bash"
  supports :manage_home => true
end

directory "#{node['bitcoin']['home']}/.bitcoin" do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0700"
end

template "#{node['bitcoin']['home']}/.bitcoin/bitcoin.conf" do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0400"
  action :create_if_missing
  notifies :run, "execute[bitcoind start]", :delayed
end

template "#{node['bitcoin']['home']}/#{node['bitcoin']['service_wrapper']}" do
  source "bitcoind.erb"
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0500"
end

include_recipe "bitcoin::install" unless ::File.exist? "#{node['bitcoin']['home']}/#{node['bitcoin']['binary']}"

