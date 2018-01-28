#
# Cookbook Name:: bitcoin
# Recipe:: binary
#

include_recipe "bitcoin::_common"

directory File.dirname(node['bitcoin']['archive_path']) do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0700"
end

remote_file node['bitcoin']['archive_path'] do
  source node['bitcoin']['binary']['url'][node['bitcoin']['variant']]
  checksum node['bitcoin']['binary']['checksum'][node['bitcoin']['variant']]
  notifies :run, "script[install_bitcoin]", :immediately
end

script "install_bitcoin" do
  action :nothing
  cwd File.dirname(node['bitcoin']['archive_path'])
  interpreter "sh"
  flags "-eux"
  code <<-SCRIPT
    mkdir -p #{node['bitcoin']['extract_path']}
    tar xvf #{node['bitcoin']['archive_path']} -C #{node['bitcoin']['extract_path']} --strip-components=1
    install -o #{node['bitcoin']['user']} -g #{node['bitcoin']['user']} -m 0500 #{node['bitcoin']['extract_path']}/bin/#{node['bitcoin']['binary_name']} #{node['bitcoin']['binary_path']}
    install -o #{node['bitcoin']['user']} -g #{node['bitcoin']['user']} -m 0500 #{node['bitcoin']['extract_path']}/bin/bitcoin-cli #{node['bitcoin']['binary_cli_path']}
    ln -svf #{node['bitcoin']['binary_path']} /bin/
    ln -svf #{node['bitcoin']['binary_cli_path']} /bin/
    rm -rf #{node['bitcoin']['extract_path']}
  SCRIPT
end

include_recipe "bitcoin::_systemd"
