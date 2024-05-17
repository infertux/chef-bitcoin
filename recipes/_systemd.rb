#
# Cookbook:: bitcoin
# Recipe:: _systemd
#

systemd_unit "#{node['bitcoin']['binary_name']}.service" do
  content <<~SYSTEMD
    [Unit]
    Description=Bitcoin daemon
    After=network.target

    [Service]
    User=#{node['bitcoin']['user']}
    Group=#{node['bitcoin']['user']}

    Type=forking
    PIDFile=#{node['bitcoin']['conf_dir']}/bitcoind.pid
    ExecStart=#{node['bitcoin']['binary_path']} -daemon -pid=#{node['bitcoin']['conf_dir']}/bitcoind.pid

    PrivateTmp=true
    ProtectHome=true
    ProtectProc=invisible
    ProtectSystem=full

    Restart=on-failure
    TimeoutStopSec=60
    TimeoutStartSec=5
    StartLimitInterval=120
    StartLimitBurst=5

    [Install]
    WantedBy=multi-user.target
  SYSTEMD

  action   %i(create enable)
  notifies :restart, "systemd_unit[#{node['bitcoin']['binary_name']}.service]"
end
