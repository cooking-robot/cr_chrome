# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/
provides :chrome_policy

property :name, String, name_property: true
property :value, [String, Array, TrueClass, FalseClass]
require 'json'

action :managed do
  if platform_family?('debian', 'rhel')
    directory '/etc/opt/chrome/policies/managed' do
      owner 'root'
      group 'root'
      mode '0755'
      action :create
      recursive true
    end
    policy_content = JSON.generate({new_resource.name => new_resource.value})

    file new_resource.name do
      path "/etc/opt/chrome/policies/managed/#{new_resource.name}"
      content policy_content
    end
  elsif platform_family?('mac_os_x')
    plist '/Library/Managed Preferences/com.google.Chrome.plist' do
      entry new_resource.name
      value new_resource.value
    end
  end
end

action :recommanded do
  if platform_family?('debian', 'rhel')
    directory '/etc/opt/chrome/policies/recommended' do
      owner 'root'
      group 'root'
      mode '0755'
      action :create
      recursive true
    end
    policy_content = JSON.generate({new_resource.name => new_resource.value})

    file new_resource.name do
      path "/etc/opt/chrome/policies/recommended/#{new_resource.name}"
      content policy_content
    end
  elsif platform_family?('mac_os_x')
    plist '/Library/Preferences/com.google.Chrome.plist' do
      entry new_resource.name
      value new_resource.value
    end
  end
end