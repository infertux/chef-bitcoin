#
# Cookbook:: bitcoin
# Recipe:: source
#

include_recipe 'bitcoin::_common'

directory File.dirname(node['bitcoin']['archive_path']) do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode '0700'
end

remote_file node['bitcoin']['archive_path'] do
  source node['bitcoin']['source']['url'][node['bitcoin']['variant']]
  checksum node['bitcoin']['source']['checksum'][node['bitcoin']['variant']]
  notifies :delete, 'file[symlink]', :immediately
end

file 'symlink' do
  action :nothing
  path "/bin/#{node['bitcoin']['binary_name']}"
end

package 'dependencies' do
  action :nothing
  package_name node['bitcoin']['source']['dependencies'].fetch(node['platform_family'])
end

script 'compile_and_install' do
  notifies :install, 'package[dependencies]', :before
  creates "/bin/#{node['bitcoin']['binary_name']}"
  cwd File.dirname(node['bitcoin']['archive_path'])
  interpreter 'sh'
  flags '-eux'
  code <<-SCRIPT
    mkdir -p #{node['bitcoin']['extract_path']}
    tar xvf #{node['bitcoin']['archive_path']} -C #{node['bitcoin']['extract_path']} --strip-components=1
    cd #{node['bitcoin']['extract_path']}
    ./autogen.sh
    ./configure #{node['bitcoin']['source']['configure_options']}
    command -v gmake && MAKE=gmake || MAKE=make
    $MAKE #{node['bitcoin']['source']['make_options']}
    $MAKE install
    install --strip -o #{node['bitcoin']['user']} -g #{node['bitcoin']['user']} -m 0500 src/#{node['bitcoin']['binary_name']} #{node['bitcoin']['binary_path']}
    install --strip -o #{node['bitcoin']['user']} -g #{node['bitcoin']['user']} -m 0500 src/#{node['bitcoin']['binary_cli_name']} #{node['bitcoin']['binary_cli_path']}
    ln -svf #{node['bitcoin']['binary_path']} /bin/
    ln -svf #{node['bitcoin']['binary_cli_path']} /bin/
    rm -rf #{node['bitcoin']['extract_path']}
  SCRIPT
end

include_recipe 'bitcoin::_systemd' if systemd?
