#
# Cookbook Name:: myiis-cookbook
# Recipe:: default
#
# Copyright 2015, Great Websites Inc
#

Chef::Log.warn "*** Hello from the myiis-cookbook::default recipe!"

# Use the 'windows_feature' resource to install IIS
windows_feature 'IIS-WebServerRole' do
  action :install
end

# Ensure the default IIS files are removed
['iisstart.htm', 'iis-85.png', 'welcome.png'].each do |file|
  file "c:/inetpub/wwwroot/#{file}" do
    action :delete
  end
end

# Change pagefile size. Normally goes into a base_cookbook
memory_150p = (node['kernel']['cs_info']['total_physical_memory'].to_i / 1024 / 1024 * 1.5).to_i
Chef::Log.warn "*** Total Memory x 1.5 = #{memory_150p}GB"
windows_pagefile 'c:\pagefile.sys' do
  initial_size memory_150p
  maximum_size memory_150p
  system_managed false
  automatic_managed false
  action :set
end

# Change the timezone if needed. Normally goes into a base_cookbook
powershell_script 'set-timezone' do
  code <<-EOH
    tzutil.exe /s '#{node['myiis-cookbook']['timezone']}'
  EOH
  not_if "$(tzutil.exe /g) -eq '#{node['myiis-cookbook']['timezone']}'"
  action :run
end
