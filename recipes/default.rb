#
# Cookbook Name:: jetty
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'java'

remote_file "#{Chef::Config[:file_cache_path]}/#{node[:jetty][:debfile]}" do
	source "#{node[:jetty][:source]}"
	action :create
end

dpkg_package "#{node[:jetty][:debpackage]}" do
	source "#{Chef::Config[:file_cache_path]}/#{node[:jetty][:debfile]}"
	action :install
end

template "/opt/jetty/etc/jetty.xml" do
	source "jetty.xml.erb"
	owner node[:jetty][:user]
	group node[:jetty][:group]
end

template "/opt/jetty/etc/webdefault.xml" do
	source "webdefault.xml.erb"
	owner node[:jetty][:user]
	group node[:jetty][:group]
end

service "jetty" do
	action :restart
end