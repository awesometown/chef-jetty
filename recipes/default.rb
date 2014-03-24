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

if node[:jetty][:clean]
	execute "remove jetty contexts" do
		command "rm -rf #{node[:jetty][:webappsdir]}/*"
	end

	execute "remove jetty webapps" do
		command "rm -rf #{node[:jetty][:contextsdir]}/*"
	end
end

template "#{node[:jetty][:homedir]}/etc/jetty.xml" do
	source "jetty.xml.erb"
	owner node[:jetty][:user]
	group node[:jetty][:group]
end

template "#{node[:jetty][:homedir]}/etc/webdefault.xml" do
	source "webdefault.xml.erb"
	owner node[:jetty][:user]
	group node[:jetty][:group]
end

service "jetty" do
	action :enable
end