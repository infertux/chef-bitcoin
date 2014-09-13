#
# Cookbook Name:: bitcoin
# Recipe:: install
#

archive_file = "bitcoin-#{node['bitcoin']['version']}-linux.tar.gz"
archive_path = "#{Chef::Config['file_cache_path']}/#{archive_file}"
extract_path = "#{Chef::Config['file_cache_path']}/bitcoin-#{node['bitcoin']['version']}"
binary_path  = "#{node['bitcoin']['home']}/#{node['bitcoin']['binary']}"

remote_file archive_path do
  source "https://bitcoin.org/bin/#{node['bitcoin']['version']}/#{archive_file}"
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0400"
  not_if { ::File.exist?(archive_path) }
end

execute "verify checksum" do
  cwd ::File.dirname(archive_path)
  command %(echo "#{node['bitcoin']['checksum']}  #{archive_file}" | sha256sum -c -)
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
