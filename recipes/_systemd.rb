#
# Cookbook Name:: bitcoin
# Recipe:: _systemd
#

bitcoin_home = "#{node['bitcoin']['home']}/.bitcoin"
bitcoin_conf = "#{bitcoin_home}/bitcoin.conf"
service_file = "/usr/lib/systemd/system/bitcoind.service"

template service_file do
  source "bitcoind.service.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    user: node['bitcoin']['user'],
    bitcoind: node['bitcoin']['source']['bitcoind'],
    bitcoin_home: bitcoin_home
  )
  notifies :run, "execute[systemd-daemon-reload]", :immediately
end

service "bitcoind" do
  supports   [status: true, start: true, stop: true, restart: true]
  action     [:enable, :start]
  subscribes :restart, "template[#{service_file}]", :delayed
  subscribes :restart, "template[#{bitcoin_conf}]", :delayed
end

execute "systemd-daemon-reload" do
  command "/usr/bin/systemctl daemon-reload"
end
