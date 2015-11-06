# abstractit/r10k
[![Circle CI](https://circleci.com/gh/abstractitptyltd/docker-r10k.svg?style=svg)](https://circleci.com/gh/abstractitptyltd/docker-r10k)
[![](https://badge.imagelayers.io/abstractit/r10k:latest.svg)](https://imagelayers.io/?images=abstractit/r10k:latest 'Get your own badge on imagelayers.io')

This is a basic container that accepts an R10K config file and ssh deploy keys and installs the modules listed.
I may add this functionality to my puppetserver container in the future but this one will stay maintained.

# Setup

If you r10k environment repo is accessed via git you will need to put your ssh keys in the ssh directory of your data volume. You can optionally add config and known_hosts files to allow git to run without complaining about the host keys of your git server.
You can also include an r10k.yaml file which will get used and your `$R10K_ENV_REPO` environment variable will be ignored.

# Running
```
docker run -d -e R10K_VERSION="1.5.1" -v $DATA_DIR:/data -v $R10K_ENVIRONMENT_DIRECTORY:/etc/puppet/environments -e $R10K_ENV_REPO:https://github.com/abstractitptyltd/puppet-env-abstractit.git abstractit/r10k
```
Then run your puppetserver with the --volumes-from flag to use the volume from this container.

# Notes

This repo is automatically built from GitHub repo [abstractitptyltd/docker-r10k](https://github.com/abstractitptyltd/docker-r10k) using CircleCI.

# Release Notes

##2015-11-06 - Pete Brown <pete@abstractit.com.au> 0.1.2
###Summary

Upgrade abstractit/puppet-base to 0.1.4
Add Imagelayers badge

##2015-10-08 - Pete Brown <pete@abstractit.com.au> 0.1.1
###Summary

Upgrade abstractit/puppet-base to 0.1.3
Streamline build steps

##2015-10-08 - Pete Brown <pete@abstractit.com.au> 0.1.0
###Summary

Initial release
