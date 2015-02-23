#
# Cookbook Name:: myiis-cookbook
# Recipe:: default
#
# Copyright 2015, Great Websites Inc
#

log "*** Hello from the myiis-cookbook::install_iis recipe!"

# Use the registry_key resource to change the startup type for the chef-client service
registry_key 'HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\chef-client' do
  values [{
    :name => "DelayedAutostart",
    :type => :dword,
    :data => 1
  }]
  action :create
end

windows_feature 'IIS-WebServerRole' do
  action :install
end

file 'c:/inetpub/wwwroot/iisstart.htm' do
  action :delete
end

file 'c:/inetpub/wwwroot/iis-85.png' do
  action :delete
end

file 'c:/inetpub/wwwroot/welcome.png' do
  action :delete
end

# Create the directory to store the msi
# http://docs.opscode.com/resource_directory.html
directory 'C:\MyKits\Google' do
  action :create
  recursive true
end

remote_file 'C:\MyKits\Google\Chrome.msi' do
  source node['chrome']['url']
  checksum node['chrome']['checksum']
  action :create
end

# Install Chrome using windows_package
# http://docs.opscode.com/lwrp_windows.html#windows-package
windows_package 'Google Chrome' do
  source 'C:\MyKits\Google\Chrome.msi'
  action :install
end

# Run a powershell_script script
powershell_script 'Create folder script' do
  code '
    if (!(Test-Path "C:\MyKits\PowershellDir")) {
      Write-Output "*** Directory C:\MyKits\PowershellDir is missing, creating it..."
      mkdir C:\MyKits\PowershellDir
    }
  '
  action :run
end

# Run a batch script
# http://docs.opscode.com/resource_batch.html
batch 'Batch demo script' do
  code '
    dir C:\MyKits
  '
  action :run
end
