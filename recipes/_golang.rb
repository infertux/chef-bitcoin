node.default['bitcoin']['go']['gopath'] = "#{node['bitcoin']['home']}/go"
node.default['bitcoin']['go']['extract_path']['btcd'] = "#{node['bitcoin']['go']['gopath']}/src/github.com/btcsuite/btcd"

node.default['go']['version'] = '1.9.3'
node.default['go']['url'] = "https://storage.googleapis.com/golang/go#{node['go']['version']}.linux-amd64.tar.gz"
node.default['go']['scm'] = false

include_recipe 'golang::default'

%w[/ /bin /src].each do |suffix|
  directory "#{node['bitcoin']['go']['gopath']}#{suffix}" do
    owner node['bitcoin']['user']
    group node['bitcoin']['group']
  end
end

bash 'check Go version' do
  flags '-l'
  user node['bitcoin']['user']
  group node['bitcoin']['group']
  code <<-BASH
    set -eux
    go version
    go version | grep -Eq '^go version go#{node['go']['version']} '
  BASH
end

package 'git' # required for Glide

bash 'install Glide' do
  flags '-l'
  user node['bitcoin']['user']
  group node['bitcoin']['group']
  code <<-BASH
    set -eux
    export GOPATH=#{node['bitcoin']['go']['gopath']}
    export GOBIN=#{node['bitcoin']['go']['gopath']}/bin
    go get github.com/Masterminds/glide
  BASH
end
