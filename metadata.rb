name 'cr_chrome'
maintainer 'Remi BONNET'
maintainer_email 'bonnet@fanaticalhelp.com'
license 'MIT'
description 'Installs/Configures Chrome browser'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://github.com/cooking-robot/cr_chrome'
issues_url 'https://github.com/cooking-robot/cr_chrome/issues'
version '4.0.2'

chef_version '>= 12.14'

supports 'centos', '>= 7.0'
supports 'redhat', '>= 7.0'
supports 'fedora'
supports 'mac_os_x'
supports 'debian'
supports 'ubuntu'
supports 'windows'

depends 'dmg', '>= 3.0'
