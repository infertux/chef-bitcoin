#
# Cookbook Name:: bitcoin
# Recipe:: source
#

include_recipe "bitcoin::_common"

variant = node['bitcoin']['source']['variant']
raise "Valid variants are core and unlimited." unless %w(core unlimited).include?(variant)

name = "bitcoin-#{variant}-#{node['bitcoin']['source'][variant]['version']}"

# install dependencies
package node['bitcoin']['source']['dependencies'].fetch(node['platform_family'])

# download the Bitcoin source code
remote_file "/usr/src/#{name}.tar.gz" do
  source node['bitcoin']['source'][variant]['url']
  checksum node['bitcoin']['source'][variant]['checksum']
  action :create_if_missing
  notifies :run, "bash[compile_and_install_bitcoin]", :immediately
end

# compile and install Bitcoin
bash "compile_and_install_bitcoin" do
  cwd "/usr/src"
  creates node['bitcoin']['source']['bitcoind']
  code <<-EOH
    test -d #{name} || (mkdir #{name} && tar xf #{name}.tar.gz -C #{name} --strip-components=1)
    (cd #{name} && ./autogen.sh && ./configure #{node['bitcoin']['source']['configure_options']} && make #{node['bitcoin']['source']['make_options']} && strip src/bitcoind && make install)
  EOH
end

include_recipe "bitcoin::_systemd"
