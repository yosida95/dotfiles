# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
PATH=$PATH:/sbin:/usr/sbin:$HOME/bin
VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7

export VIRTUALENVWRAPPER_PYTHON
export PATH
unset USERNAME

if [ -f /usr/bin/virtualenvwrapper.sh ]; then
    source /usr/bin/virtualenvwrapper.sh
fi
