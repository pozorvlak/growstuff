git init .
git submodule add https://github.com/cbetta/rails-vagrant-setup.git puppet
cp puppet/Vagrantfile .
cp puppet/database.yml config/
vagrant up
