#
# Cookbook Name:: myiis-cookbook
# Recipe:: default
#
# Copyright 2015, Great Websites Inc
#

log "*** Hello from the myiis-cookbook::install_iis recipe!"

windows_feature 'IIS-WebServerRole' do
	action :install
end

file 'c:/inetpub/wwwroot/iisstart.htm' do
  action :delete
end

file 'c:/inetpub/wwwroot/iis-85.png' do
  action :delete
end

# Creates a directory with proper permissions
# http://docs.opscode.com/resource_directory.html
directory 'C:\MyKits\Chrome' do
  action :create
  recursive true
end

# Download the Chrome msi from the source link if missing
remote_file 'C:\MyKits\Chrome\GoogleChromeStandaloneEnterprise.msi' do
  source node['chrome']['url']
  checksum node['chrome']['checksum']
  action :create
end

# Run a batch command
# http://docs.opscode.com/resource_batch.html
batch 'Output directory list' do
  code '
    dir C:\MyKits\Chrome
    echo "Hello World!"
  '
  action :run
end

# Install Chrome using windows_package
# http://docs.opscode.com/lwrp_windows.html#windows-package
windows_package 'Google Chrome' do
  source 'C:\MyKits\Chrome\GoogleChromeStandaloneEnterprise.msi'
  action :install
end

windows_path 'C:\Program Files (x86)\Google\Chrome\Application' do
  action :add
end
