#
# Cookbook Name:: myiis-cookbook
# Recipe:: default
#
# Copyright 2015, Great Websites Inc
#

Chef::Log.warn "*** Hello from the myiis-cookbook::default recipe!"

memory_150p = (node['kernel']['cs_info']['total_physical_memory'].to_i / 1024 / 1024 * 1.5).to_i

Chef::Log.warn "*** Total Memory x 1.5 = #{memory_150p}GB"

windows_pagefile 'c:\pagefile.sys' do
  initial_size memory_150p
  maximum_size memory_150p
  system_managed false
  automatic_managed false
  action :set
end

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

%w(iisstart.htm iis-85.png welcome.png).each do |file|
  file "c:/inetpub/wwwroot/#{file}" do
    action :delete
  end
end