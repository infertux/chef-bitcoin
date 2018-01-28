#
# Cookbook Name:: bitcoin
# Recipe:: git
#

include_recipe "bitcoin::_common"
include_recipe "bitcoin::_golang"

directory node['bitcoin']['go']['extract_path'][node['bitcoin']['variant']] do
  user node['bitcoin']['user']
  group node['bitcoin']['group']
  recursive true
end

git node['bitcoin']['go']['extract_path'][node['bitcoin']['variant']] do
  repository node['bitcoin']['git']['url'][node['bitcoin']['variant']]
  notifies :run, "script[compile_and_install_bitcoin]", :immediately
end

script "compile_and_install_bitcoin" do
  action :nothing
  cwd node['bitcoin']['go']['extract_path'][node['bitcoin']['variant']]
  interpreter "sh"
  flags "-eux"
  code <<-SCRIPT
    export GOPATH=#{node['bitcoin']['go']['gopath']}
    export GOBIN=#{node['bitcoin']['go']['gopath']}/bin
    export PATH=/usr/local/go/bin:$GOBIN:$PATH
    glide install
    go install . ./cmd/...
    ln -svf #{node['bitcoin']['go']['gopath']}/bin/#{node['bitcoin']['binary_name']} /bin/
    ln -svf #{node['bitcoin']['go']['gopath']}/bin/#{node['bitcoin']['binary_cli_name']} /bin/
  SCRIPT
end

include_recipe "bitcoin::_systemd"
