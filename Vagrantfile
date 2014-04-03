# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "chef-jetty"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"
  config.vm.network "forwarded_port", guest: 8080, host: 18081

  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :java => {
        :jdk_version => 7,
        :install_flavor => "openjdk"
      },
      :jetty => {
      	:user => "vagrant",
      	:group => "vagrant"
      },
    }
    chef.run_list = [
      "recipe[jetty::default]"
    ]
  end
end
