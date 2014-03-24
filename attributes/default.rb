default[:jetty][:user] = "ec2-user"
default[:jetty][:group] = "ec2-user"
default[:jetty][:version] = "8.1.9.v20130131"
default[:jetty][:debfile] = "jetty-deb-#{node[:jetty][:version]}.deb"
default[:jetty][:source] = "http://central.maven.org/maven2/org/mortbay/jetty/dist/jetty-deb/#{node[:jetty][:version]}/#{node[:jetty][:debfile]}"
default[:jetty][:debpackage] = "jetty-hightide-server"
default[:jetty][:clean] = true

default[:jetty][:homedir] = "/opt/jetty"
default[:jetty][:webappsdir] = "#{node[:jetty][:homedir]}/webapps"
default[:jetty][:contextsdir] = "#{node[:jetty][:homedir]}/contexts"