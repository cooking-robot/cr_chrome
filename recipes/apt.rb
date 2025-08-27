apt_repository 'google-chrome' do
  arch node['chrome']['apt_arch']
  uri node['chrome']['apt_uri']
  distribution 'stable'
  components %w(main)
  key node['chrome']['apt_key']
  action :add
end

package "google-chrome-#{node['chrome']['track']}" do
  action :install
end
