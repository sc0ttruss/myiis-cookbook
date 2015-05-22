#
# Cookbook Name:: myiis-cookbook
# Recipe:: app_checkout
#
# Copyright 2015, Great Websites Inc
#

Chef::Log.warn "*** Hello from the myiis-cookbook::install_iis recipe!"

include_recipe 'git::default'

# Add app version to node data. Unknown for now
node.set['myiis-cookbook']['app-ver'] = 'unknown'

# Use the 'git' resource to checkout from the provided repository
git node['myiis-cookbook']['doc-root'] do
  repository node['myiis-cookbook']['git-repo']
  revision node['myiis-cookbook']['git-revision']
  action :sync
  notifies :run, "powershell_script[dir_wwwroot]", :immediately
  notifies :run, "ruby_block[retrieve_version]", :immediately
end

powershell_script 'dir_wwwroot' do
  code '
    dir c:\inetpub\wwwroot
  '
  action :nothing
end

# Get the app version from VERSION.txt and add it to the node data
ruby_block 'retrieve_version' do
  block do
    version = File.open("#{node['myiis-cookbook']['doc-root']}/VERSION.txt").readline.chomp
    node.set['myiis-cookbook']['app-ver'] = version
  end
  only_if { File.exist?("#{node['myiis-cookbook']['doc-root']}/VERSION.txt") }
  action :nothing
end


