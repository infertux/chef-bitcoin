#
# Cookbook Name:: bitcoin
# Recipe:: binary
#

btc_home = "#{node['bitcoin']['binary']['home']}/.bitcoin"
btc_conf = "#{btc_home}/bitcoin.conf"

user node['bitcoin']['user'] do
  home node['bitcoin']['binary']['home']
  shell "/bin/bash"
  supports manage_home: true
end

directory btc_home do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0700"
end

template btc_conf do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0600"
  action :create_if_missing
end

archive_file = "bitcoin-#{node['bitcoin']['binary']['version']}-linux64.tar.gz"
archive_path = "#{Chef::Config['file_cache_path']}/bitcoin/#{archive_file}"
extract_path = "#{Chef::Config['file_cache_path']}/bitcoin/bitcoin-#{node['bitcoin']['binary']['version']}"
binary_path  = "#{node['bitcoin']['home']}/#{node['bitcoin']['binary']['bitcoind']}"

remote_file archive_path do
  source "https://bitcoin.org/bin/#{node['bitcoin']['binary']['version']}/#{archive_file}"
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0400"
  not_if { ::File.exist?(archive_path) }
end

execute "verify checksum" do
  cwd ::File.dirname(archive_path)
  command %(echo "#{node['bitcoin']['binary']['checksum']}  #{archive_file}" | sha256sum -c -)
end

directory ::File.dirname(binary_path) do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0700"
  recursive true
end

bash "extract archive" do
  cwd ::File.dirname(archive_path)
  code <<-EOH
    rm -rf #{extract_path}
    mkdir -p #{extract_path}
    tar xf #{archive_file} -C #{extract_path}
    cp #{extract_path}/*/bin/64/bitcoind #{binary_path} # FIXME: don't hard-code "64"
  EOH
end

file binary_path do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0500"
end

# create init file
template "/etc/init.d/#{node['bitcoin']['binary']['service_wrapper']}" do
  source "initscript.erb"
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0500"
  variables(
    bitcoind:   node['bitcoin']['binary']['bitcoind'],
    bitcoincli: node['bitcoin']['binary']['bitcoin-cli'],
    btc_home:   btc_home
  )
end

service node['bitcoin']['binary']['service_wrapper'] do
  supports   [status: true, start: true, stop: true, restart: true]
  action     [:enable, :start]
  subscribes :restart, "template[/etc/init.d/#{node['bitcoin']['binary']['service_wrapper']}]", :delayed
end
