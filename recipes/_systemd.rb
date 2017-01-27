#
# Cookbook Name:: bitcoin
# Recipe:: _systemd
#

directory File.dirname(node['bitcoin']['service_file']) do
  user "root"
  group "root"
  mode "0755"
end

template node['bitcoin']['service_file'] do
  source "bitcoind.service.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    user: node['bitcoin']['user'],
    bitcoind: node['bitcoin']['bitcoind'],
    conf_dir: node['bitcoin']['conf_dir']
  )
  # notifies :run, "execute[systemd-daemon-reload]", :immediately # FIXME: systemd isn't working within Docker
end

service "bitcoind" do
  provider   Chef::Provider::Service::Systemd
  action     [:enable]
  # subscribes :restart, "template[#{node['bitcoin']['service_file']}]", :delayed # FIXME: systemd isn't working with Docker
  # subscribes :restart, "template[#{node['bitcoin']['conf_file']}]", :delayed # FIXME: systemd isn't working with Docker
end

execute "systemd-daemon-reload" do
  action :nothing
  command "systemctl daemon-reload"
end
