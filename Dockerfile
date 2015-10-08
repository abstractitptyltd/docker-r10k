FROM abstractit/puppet-base:0.1.3
MAINTAINER Abstract IT Pty Ltd <dev@abstractit.com.au>
LABEL vendor="Abstract IT Pty Ltd" \
  au.com.abstractit.version="0.1.1" \
  au.com.abstractit.is-beta="true" \
  au.com.abstractit.release-date="2015-10-08"

ENV R10K_VERSION="1.5.1" \
  GIT_VERSION="1.8.3.1" \
  R10K_ENV_REPO=""

RUN yum install -y \
  git-$GIT_VERSION \
  && yum -y clean all

RUN mkdir -p /etc/puppetlabs/r10k \
  && mkdir /root/.ssh \
  && chown root:root /root/.ssh \
  && chmod og-rwx /root/.ssh \
  && mkdir -p /opt/puppetlabs/r10k/cache \
  && mkdir -p /etc/puppet/environments

# install r10k gem
RUN gem install r10k --version $R10K_VERSION --no-ri --no-rdoc

# add config/startup script
ADD run.sh /run.sh
RUN chmod +x /run.sh

# add volumes for non static
VOLUME ["/etc/puppet/environments"]
VOLUME ["/data"]

CMD ["/run.sh"]