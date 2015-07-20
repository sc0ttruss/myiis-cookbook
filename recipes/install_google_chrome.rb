#
# Cookbook Name:: myiis-cookbook
# Recipe:: install_google_chrome
#
# Copyright 2015, Great Websites Inc
#

Chef::Log.warn '*** This is the install_google_chrome recipe'

# Use the 'directory' resource to ensure that 'C:\MyKits\Google exists
# http://docs.opscode.com/resource_directory.html
directory 'C:\MyKits\Google' do
  recursive true
  action :create
end

# Use the 'remote_file' to idempotently download the Google Chrome msi
remote_file 'C:\MyKits\Google\Chrome.msi' do
  source node['myiis-cookbook']['chrome']['url']
  checksum node['myiis-cookbook']['chrome']['checksum']
  action :create
  notifies :run, "batch[dir_google]", :immediately
end

# Use the 'batch' resource to run a batch script only when notified by the previous 'remove_file' resource 
# http://docs.opscode.com/resource_batch.html
batch 'dir_google' do
  code 'dir C:\MyKits\Google'
  action :nothing
end

# Use the 'windows_package' resource to idempotently install Google Chrome
# http://docs.opscode.com/lwrp_windows.html#windows-package
windows_package 'Google Chrome' do
  source 'C:\MyKits\Google\Chrome.msi'
  action :install
end

