#
# Cookbook Name:: myiis-cookbook
# Recipe:: app_checkout
#
# Copyright 2015, Great Websites Inc
#

log "*** Hello from the myiis-cookbook::install_iis recipe!"

include_recipe 'git::windows'

# Add app version to node data. Unknown for now
node.set['myiis-cookbook']['app-ver'] = 'unknown'

# Use the 'git' resource to checkout from the provided repository
git node['myiis-cookbook']['doc-root'] do
  repository node['myiis-cookbook']['git-repo']
  revision node['myiis-cookbook']['git-revision']
  action :sync
end

powershell_script 'dir git folder' do
  code '
    dir c:\inetpub\wwwroot
  '
  action :run
end

# Get the app version from VERSION.txt and add it to the node data
ruby_block 'Retrieve app version' do
  block do
    version = File.open("#{node['myiis-cookbook']['doc-root']}/VERSION.txt").readline.chomp
    node.set['myiis-cookbook']['app-ver'] = version
  end
  only_if { File.exist?("#{node['myiis-cookbook']['doc-root']}/VERSION.txt") }
  action :run
end


