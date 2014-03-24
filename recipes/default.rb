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

remote_file "#{Chef::Config[:file_cache_path]}/jetty-deb-8.1.9.v20130131.deb" do
	source "http://central.maven.org/maven2/org/mortbay/jetty/dist/jetty-deb/8.1.9.v20130131/jetty-deb-8.1.9.v20130131.deb"
	action :create
end

dpkg_package "jetty-hightide-server" do
	source "#{Chef::Config[:file_cache_path]}/jetty-deb-8.1.9.v20130131.deb"
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