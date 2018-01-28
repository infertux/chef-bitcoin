#
# Cookbook Name:: bitcoin
# Recipe:: source
#

include_recipe "bitcoin::_common"

package node['bitcoin']['source']['dependencies'].fetch(node['platform_family'])

directory File.dirname(node['bitcoin']['archive_path']) do
  owner node['bitcoin']['user']
  group node['bitcoin']['user']
  mode "0700"
end

remote_file node['bitcoin']['archive_path'] do
  source node['bitcoin']['source']['url'][node['bitcoin']['variant']]
  checksum node['bitcoin']['source']['checksum'][node['bitcoin']['variant']]
  notifies :run, "script[compile_and_install_bitcoin]", :immediately
end

script "compile_and_install_bitcoin" do
  action :nothing
  cwd File.dirname(node['bitcoin']['archive_path'])
  interpreter "sh"
  flags "-eux"
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

package node['bitcoin']['source']['dependencies'].fetch(node['platform_family']) do
  action :remove
end

include_recipe "bitcoin::_systemd"
