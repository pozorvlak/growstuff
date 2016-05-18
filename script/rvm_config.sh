# Load RVM into a shell session *as a function*
# This is required to make "rvm use" and "rvm gemset use" work.
# This script is sourced from the vagrant user's .profile.

RVM_HOME=/usr/share/rvm
[[ -s "$RVM_HOME/scripts/rvm" ]] && source "$RVM_HOME/scripts/rvm"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/
