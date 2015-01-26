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

file 'c:/inetpub/wwwroot/welcome.png' do
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

# Install Chrome using windows_package
# http://docs.opscode.com/lwrp_windows.html#windows-package
windows_package 'Google Chrome' do
  source 'C:\MyKits\Chrome\GoogleChromeStandaloneEnterprise.msi'
  action :install
end

# Update Path using a DSC Environment resource
# Requires Powershell 4+
dsc_script 'Update Path for Chrome' do
  flags ({ :Drive => 'C' })
  code <<-EOH
  Environment 'texteditor'
  {
    Name = 'Path'
    Path = $true
    Value = "${Drive}:\\Program Files (x86)\\Google\\Chrome\\Application"
  }
  EOH
end

# Update Path using a Chef windows_path resource
windows_path 'C:\Test' do
	  action :add
end
