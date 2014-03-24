directory "#{node[:jetty][:homedir]}/lib/logging" do
	owner node[:jetty][:user]
	group node[:jetty][:group]
end

remote_file "#{node[:jetty][:homedir]}/lib/logging/slf4j-api-1.7.6.jar" do
	source "http://search.maven.org/remotecontent?filepath=org/slf4j/slf4j-api/1.7.6/slf4j-api-1.7.6.jar"
	owner node[:jetty][:user]
	group node[:jetty][:group]
	notifies :restart, "service[jetty]", :delayed
end

remote_file "#{node[:jetty][:homedir]}/lib/logging/logback-classic-1.1.1.jar" do
	source "http://search.maven.org/remotecontent?filepath=ch/qos/logback/logback-classic/1.1.1/logback-classic-1.1.1.jar"
	owner node[:jetty][:user]
	group node[:jetty][:group]
	notifies :restart, "service[jetty]", :delayed
end

remote_file "#{node[:jetty][:homedir]}/lib/logging/logback-core-1.1.1.jar" do
	source "http://search.maven.org/remotecontent?filepath=ch/qos/logback/logback-core/1.1.1/logback-core-1.1.1.jar"
	owner node[:jetty][:user]
	group node[:jetty][:group]
	notifies :restart, "service[jetty]", :delayed
end

template "#{node[:jetty][:homedir]}/etc/jetty-logging.xml" do
	source "jetty-logging.xml.erb"
	owner node[:jetty][:user]
	group node[:jetty][:group]
	notifies :restart, "service[jetty]", :delayed
end

template "#{node[:jetty][:homedir]}/resources/logback.xml" do
	source "logback.xml.erb"
	owner node[:jetty][:user]
	group node[:jetty][:group]
	notifies :restart, "service[jetty]", :delayed
end
