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
  action :create_if_missing
  notifies :run, "bash[compile_and_install_bitcoin]", :immediately
end

bash "compile_and_install_bitcoin" do
  cwd File.dirname(node['bitcoin']['archive_path'])
  creates node['bitcoin']['bitcoind']
  code <<-EOH
    rm -rf #{node['bitcoin']['extract_path']}
    mkdir -p #{node['bitcoin']['extract_path']}
    tar xvf #{node['bitcoin']['archive_path']} -C #{node['bitcoin']['extract_path']} --strip-components=1
    cd #{node['bitcoin']['extract_path']}
    ./autogen.sh
    ./configure #{node['bitcoin']['source']['configure_options']}
    make #{node['bitcoin']['source']['make_options']}
    strip src/bitcoind
    strip src/bitcoin-cli
    make install
    install -o #{node['bitcoin']['user']} -g #{node['bitcoin']['user']} -m 0500 src/bitcoind #{node['bitcoin']['bitcoind']}
    install -o #{node['bitcoin']['user']} -g #{node['bitcoin']['user']} -m 0500 src/bitcoin-cli #{node['bitcoin']['bitcoin_cli']}
    ln -svf #{node['bitcoin']['bitcoind']} /bin/
    ln -svf #{node['bitcoin']['bitcoin_cli']} /bin/
  EOH
end

include_recipe "bitcoin::_systemd"
