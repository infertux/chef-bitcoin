#
# Cookbook Name:: bitcoin
# Recipe:: source
#

btc_home = "#{node['bitcoin']['source']['home']}/.bitcoin"
btc_conf = "#{btc_home}/bitcoin.conf"

# add bitcoin user
user node['bitcoin']['user'] do
  home node['bitcoin']['source']['home']
  shell "/bin/bash"
  supports manage_home: true
end

# install dependencies
node['bitcoin']['source']['dependencies'].each do |dependency|
  package dependency
end

# download the Bitcoin Core source code
remote_file "/usr/src/bitcoin-#{node['bitcoin']['source']['version']}.zip" do
  source "https://github.com/bitcoin/bitcoin/archive/v#{node['bitcoin']['source']['version']}.zip"
  checksum node['bitcoin']['source']['checksum']
  action :create_if_missing
  notifies :run, "bash[install_bitcoin]", :immediately
end

# compile and install Bitcoin Core
bash "install_bitcoin" do
  cwd "/usr/src"
  creates node['bitcoin']['source']['bitcoind']
  code <<-EOH
    test -d bitcoin-#{node['bitcoin']['source']['version']} || unzip bitcoin-#{node['bitcoin']['source']['version']}.zip
    (cd bitcoin-#{node['bitcoin']['source']['version']}/ && ./autogen.sh && ./configure #{node['bitcoin']['source']['configure_options']} && make #{node['bitcoin']['source']['make_options']} && strip src/bitcoind && make install)
  EOH
end

# ensure the Bitcoin home is there
directory btc_home do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0700"
end

# configure bitcoin
template btc_conf do
  source "bitcoin.conf.erb"
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0600"
  action :create
end

# create init file
template "/etc/init.d/#{node['bitcoin']['source']['service_wrapper']}" do
  source "initscript.erb"
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0500"
  variables(
    bitcoind:   node['bitcoin']['source']['bitcoind'],
    bitcoincli: node['bitcoin']['source']['bitcoin-cli'],
    btc_home:   btc_home
  )
end

service node['bitcoin']['source']['service_wrapper'] do
  supports   [status: true, start: true, stop: true, restart: true]
  action     [:enable, :start]
  subscribes :restart, "template[/etc/init.d/#{node['bitcoin']['source']['service_wrapper']}]", :delayed
  subscribes :restart, "template[#{btc_conf}]", :delayed
end
