#!/bin/bash
#
# Run some setup and run R10K

# copy in ssh keys and fix permissions if they exist
if [ -e /data/ssh ]; then
  cp /data/ssh/* /root/.ssh/
  chown -R root:root /root/.ssh
  chmod og-rwx /root/.ssh/id_*
fi

if [ -e /data/r10k.yaml ]; then
  # copy in r10k.conf
  cp /data/r10k.yaml /etc/puppetlabs/r10k/r10k.yaml
else
  if [ -n $R10K_ENV_REPO ]; then
  # add repo to config file
  cat << EOF > /etc/puppetlabs/r10k/r10k.yaml
# The location to use for storing cached Git repos
:cachedir: '/opt/puppetlabs/r10k/cache'

# A list of git repositories to create
:sources:
  # This will clone the git repository and instantiate an environment per
  # branch in /etc/puppet/environments
  puppet:
    prefix: false
    remote: '$R10K_ENV_REPO'
    basedir: '/etc/puppet/environments'
EOF
  else
    echo "R10K_ENV_REPO not set"
  fi

fi

if [ -e /etc/puppetlabs/r10k/r10k.yaml ]; then
  r10k deploy environment -pv
else
  echo "no r10k.yaml for or R10K_ENV_REPO not set"
  exit
fi
