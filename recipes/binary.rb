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
end

bash "install_bitcoin" do
  cwd File.dirname(node['bitcoin']['archive_path'])
  creates node['bitcoin']['bitcoind']
  flags "-eux"
  code <<-EOH
    mkdir -p #{node['bitcoin']['extract_path']}
    tar xvf #{node['bitcoin']['archive_path']} -C #{node['bitcoin']['extract_path']} --strip-components=1
    install -o #{node['bitcoin']['user']} -g #{node['bitcoin']['user']} -m 0500 #{node['bitcoin']['extract_path']}/bin/bitcoind #{node['bitcoin']['bitcoind']}
    install -o #{node['bitcoin']['user']} -g #{node['bitcoin']['user']} -m 0500 #{node['bitcoin']['extract_path']}/bin/bitcoin-cli #{node['bitcoin']['bitcoin_cli']}
    ln -svf #{node['bitcoin']['bitcoind']} /bin/
    ln -svf #{node['bitcoin']['bitcoin_cli']} /bin/
    rm -rf #{node['bitcoin']['extract_path']}
  EOH
end

include_recipe "bitcoin::_systemd"
