Vagrant::Config.run do |config|
  config.vm.box       = 'precise32'
  config.vm.box_url   = 'http://files.vagrantup.com/precise32.box'
  config.vm.host_name = 'box'

  config.vm.forward_port 3000, 3000
  config.vm.forward_port 8080, 8080

  config.vm.provision :puppet,
    :manifests_path => 'puppet/manifests',
    :module_path    => 'puppet/modules'

  config.ssh.forward_agent = true
end
