#
# Cookbook Name:: bitcoin
# Recipe:: package
#

include_recipe "bitcoin::_common"

repo_url = node['bitcoin']['package']['repo_url'][node['platform_family']]
repo_file = ::File.basename(repo_url)
repo_path = "#{Chef::Config['file_cache_path']}/bitcoin/#{repo_file}"

directory ::File.dirname(repo_path) do
  recursive true
end

remote_file repo_path do
  source repo_url
  checksum node['bitcoin']['package']['repo_checksum'][node['platform_family']]
end

package "bitcoin-release" do
  source repo_path
end

variant = \
  case node['bitcoin']['variant']
  when "core" then "bitcoin"
  when "xt" then "bitcoinxt"
  else raise "Valid variants are core and xt."
  end

package "#{variant}-server" do
  only_if do
    Chef::Log.warn('The installation of bitcoin may take several minutes while the SELinux policies are being built.')

    true # NOTE: just a hack to display the above message at the right time
  end
end

service node['bitcoin']['binary_name'] do
  provider Chef::Provider::Service::Systemd
  action [:enable]
  only_if "test -f /bin/systemctl && /bin/systemctl"
end
