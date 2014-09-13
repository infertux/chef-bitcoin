#
# Cookbook Name:: bitcoin
# Recipe:: package
#

repo_url = node['bitcoin']['package']['repo_url'][node['platform_family']]
fail "No package for #{node['platform_family']}" unless repo_url

repo_file = ::File.basename(repo_url)
repo_path = "#{Chef::Config['file_cache_path']}/bitcoin/#{repo_file}"

directory ::File.dirname(repo_path) do
  recursive true
end

remote_file repo_path do
  source repo_url
  not_if { ::File.exist?(repo_path) }
end

execute "verify checksum" do
  cwd ::File.dirname(repo_path)
  command %(echo "#{node['bitcoin']['package']['repo_checksum'][node['platform_family']]}  #{repo_file}" | sha256sum -c -)
end

package "bitcoin-release" do
  source repo_path
end

package "bitcoin-server" do
  only_if do
    Chef::Log.info('The installation if bitcoin-server may take several minutes while the SELinux policies are being built.')

    true # NOTE: just a hack to display the above message at the right time
  end
end

template "/etc/bitcoin/bitcoin.conf" do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0600"
  action :create_if_missing
end

service "bitcoin" do
  action [:enable, :start]
end
