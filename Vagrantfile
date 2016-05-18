# -*- mode: ruby -*-
# vi: set ft=ruby :

# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provider "virtualbox" do |vb|
    # 2GB of memory is enough to build our dependencies, but PhantomJS (used
    # for front-end tests) is even hungrier.
    vb.memory = "4096"
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-add-repository -y ppa:rael-gc/rvm
    apt-get update
    apt-get install -y postgresql libpq-dev git phantomjs rvm
    su postgres -c $'psql -c "ALTER USER postgres WITH PASSWORD \'password\';"'
    usermod -a -G rvm vagrant
    echo '. /vagrant/script/rvm_config.sh' >> ~vagrant/.profile
    echo
    echo 'Installation of system libraries complete! Now run'
    echo
    echo '   vagrant ssh'
    echo '   cd /vagrant'
    echo '   ./script/build-env.sh'
  SHELL
end
