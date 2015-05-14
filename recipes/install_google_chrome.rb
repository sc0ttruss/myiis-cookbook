log '*** This is the install_google_chrome recipe'

# Creates a directory with proper permissions
# http://docs.opscode.com/resource_directory.html
directory 'C:\MyKits\Google' do
  recursive true
  action :create
end

remote_file 'C:\MyKits\Google\Chrome.msi' do
  source node['myiis-cookbook']['chrome']['url']
  checksum node['myiis-cookbook']['chrome']['checksum']
  action :create
end

# http://docs.opscode.com/resource_batch.html
batch 'Output directory list' do
  code 'dir C:\MyKits\Google'
  action :run
end

# Install Chrome using windows_package
# http://docs.opscode.com/lwrp_windows.html#windows-package
windows_package 'Google Chrome' do
  source 'C:\MyKits\Google\Chrome.msi'
  action :install
end

