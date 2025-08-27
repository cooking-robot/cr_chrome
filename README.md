This cookbook installs Google Chrome browser (https://www.google.com/chrome/) at compile time, provides 
`chrome_version` library method  to retrieve Chrome version installed, and provides `master_preferences` and `chrome_policy` resources
to set user preferences and policies.

This project is a part of Cooking Robot group. It's a fork of a great project: https://github.com/dhoer/chef-chrome.

## Requirements

Chef 12.14+

### Platforms

- CentOS 7, Red Hat 7, Fedora
- Debian, Ubuntu
- Mac OS X
- Windows

### Recipes

- dmg - used by Mac OS X platform 
- apt - used by Debian familiy
- msi - used by Windows family
- yum - used by RedHat Family
- default - Call another recipe for current OS

## Usage

Include the default recipe on a node's runlist to ensure that Chrome is installed.

A library method `chrome_version` is provided to retrieve the Chrome version installed:

```ruby
v = chrome_version
```

**Tip:** use `allow_any_instance_of` to stub chrome_version method when testing with rspec:

```ruby
allow_any_instance_of(Chef::Recipe).to receive(:chrome_version).and_return('50.0.0.0')
```

### Attributes

- `node['chrome']['track']` - For Linux only. Install stable, beta or unstable version. Default is `stable`.
- `node['chrome']['32bit_only']` - For windows only. Install 32-bit browser on 64-bit machines. Default is `false`.

See [attributes/default.rb](https://github.com/dhoer/chef-chrome/blob/master/attributes/default.rb) for complete list 
of attributes.

## chrome_policy

Manage chrome policies for administrators.
[More info...](https://chromeenterprise.google/policies/)

### Resource Attributes

- `name` - The name of the policy
- `value` - Value of the policy

### Actions

Action can be `:managed` or `:recommanded`. Managed policy is enforced. Recommanded policy is set by default but
the user can change theses policies. 

### Exemples

The following resource configure the home page. See [Chrome documentation](https://chromeenterprise.google/policies/#HomepageLocation).

```ruby
chrome_policy 'HomepageLocation' do
  value 'https://mycompany.com/'
end
```

## master_preferences 

Manage a template resource that configures master_preferences.
[More info...](http://www.chromium.org/administrators/configuring-other-preferences)

### Resource Attributes

- `name` - The name of the preference. 
- `cookbook` - Optional. Cookbook where the source template is. If this is not defined, Chef will use the named 
template in the cookbook where the definition is used.
- `template` - Default `master_preferences.json.erb`, source template file.
- `parameters` - Additional parameters, see Examples.

### Examples
    
The following example would look for a template named `master_preferences.json.erb` in your cookbook:

```ruby
chrome 'custom_preferences' do
  parameters(
    homepage: 'https://mycompany.com/'
    import_bookmarks_from_file: 'c:\path\to\bookmarks.html'
  )
  action :master_preferences
end
```

The Chrome cookbook comes with a `master_preferences.json.erb` template as an example. The following parameter is used 
in the template:

- `homepage` - Sets the homepage URL.

To use the default template preferences, set cookbook to `chrome`, for example:

```ruby
chrome 'set_user_preferences' do
  cookbook 'chrome'
  parameters(
    homepage: 'https://www.getchef.com'
  )
  action :master_preferences
end
```
    
The parameter specified will be used as:

- `@parameters[:homepage]`

In the template, when you write your own, the `@` is significant.

## ChefSpec Matchers

This cookbook includes custom [ChefSpec](https://github.com/sethvargo/chefspec) matchers you can use to test your 
own cookbooks.

Example Matcher Usage

```ruby
expect(chef_run).to master_preferences_chrome('name').with(
  parameters: {
    homepage: 'https://www.getchef.com'
  }
)
```
      
Cookbook Matchers

- master_preferences_chrome(name)

