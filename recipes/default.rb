case node['platform_family']
when 'windows'
  include_recipe '::msi'
when 'mac_os_x'
  include_recipe '::dmg'
when 'rhel', 'fedora'
  include_recipe '::yum'
when 'debian'
  include_recipe '::apt'
else
  Chef::Log.warn('Chrome cannot be installed on this platform using this cookbook.')
end
