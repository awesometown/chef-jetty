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

	template "#{node[:jetty][:homedir]}/etc/webdefault.xml" do
		source "webdefault.xml.erb"
		owner node[:jetty][:user]
		group node[:jetty][:group]
	end
end

template "#{node[:jetty][:homedir]}/etc/jetty.xml" do
	source "jetty.xml.erb"
	owner node[:jetty][:user]
	group node[:jetty][:group]
end

service "jetty" do
	action :enable
end

if node[:jetty][:logbackaccess][:enabled] or node[:jetty][:logbackaccess][:enabled] then
	remote_file "#{node[:jetty][:homedir]}/lib/ext/slf4j-api-1.7.6.jar" do
		source "http://search.maven.org/remotecontent?filepath=org/slf4j/slf4j-api/1.7.6/slf4j-api-1.7.6.jar"
		owner node[:jetty][:user]
		group node[:jetty][:group]
		notifies :restart, "service[jetty]", :delayed
	end

	remote_file "#{node[:jetty][:homedir]}/lib/ext/logback-classic-1.1.1.jar" do
		source "http://search.maven.org/remotecontent?filepath=ch/qos/logback/logback-classic/1.1.1/logback-classic-1.1.1.jar"
		owner node[:jetty][:user]
		group node[:jetty][:group]
		notifies :restart, "service[jetty]", :delayed
	end

	remote_file "#{node[:jetty][:homedir]}/lib/ext/logback-core-1.1.1.jar" do
		source "http://search.maven.org/remotecontent?filepath=ch/qos/logback/logback-core/1.1.1/logback-core-1.1.1.jar"
		owner node[:jetty][:user]
		group node[:jetty][:group]
		notifies :restart, "service[jetty]", :delayed
	end

	remote_file "#{node[:jetty][:homedir]}/lib/ext/logstash-logback-encoder-2.5.jar" do
		source "http://search.maven.org/remotecontent?filepath=net/logstash/logback/logstash-logback-encoder/2.5/logstash-logback-encoder-2.5.jar"
		owner node[:jetty][:user]
		group node[:jetty][:group]
		notifies :restart, "service[jetty]", :delayed
	end
end

if node[:jetty][:logback][:enabled] then
	template "#{node[:jetty][:homedir]}/resources/logback.xml" do
		source "logback.xml.erb"
		owner node[:jetty][:user]
		group node[:jetty][:group]
		notifies :restart, "service[jetty]", :delayed
	end
end


if node[:jetty][:logbackaccess][:enabled] then
	remote_file "#{node[:jetty][:homedir]}/lib/ext/logback-access-1.1.1.jar" do
		source "http://search.maven.org/remotecontent?filepath=ch/qos/logback/logback-access/1.1.1/logback-access-1.1.1.jar"
		owner node[:jetty][:user]
		group node[:jetty][:group]
		notifies :restart, "service[jetty]", :delayed
	end

	template "#{node[:jetty][:homedir]}/resources/logback-access.xml" do
		source "logback-access.xml.erb"
		owner node[:jetty][:user]
		group node[:jetty][:group]
		notifies :restart, "service[jetty]", :delayed
	end
end