name             'bitcoin'
maintainer       'Cédric Félizard'
maintainer_email 'cedric@felizard.fr'
license          'MIT'
description      'Installs and configures Bitcoin'
source_url       'https://github.com/infertux/chef-bitcoin'
issues_url       'https://github.com/infertux/chef-bitcoin/issues'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.6.0'
chef_version     '>= 13.0'

supports 'debian'
supports 'ubuntu'
supports 'centos'
supports 'freebsd'

depends 'golang'
