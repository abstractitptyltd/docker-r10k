FROM abstractit/puppet-base:0.1.1
MAINTAINER Abstract IT Pty Ltd <dev@abstractit.com.au>
LABEL vendor="Abstract IT Pty Ltd"
LABEL au.com.abstractit.version="0.1.0"
LABEL au.com.abstractit.is-beta="true"
LABEL au.com.abstractit.release-date="2015-10-07"

ENV R10K_VERSION="1.5.1"
ENV GIT_VERSION="1.8.3.1"
ENV R10K_ENV_REPO=""

RUN yum install -y \
  git-$GIT_VERSION \
  && yum -y clean all

RUN mkdir -p /etc/puppetlabs/r10k \
  && mkdir /root/.ssh \
  && chown root:root /root/.ssh \
  && chmod og-rwx /root/.ssh \
  && mkdir -p /opt/puppetlabs/r10k/cache \
  && mkdir -p /etc/puppet/environments

# install r10k
RUN gem install r10k --version $R10K_VERSION --no-ri --no-rdoc

# add config/startup script
ADD run.sh /run.sh
RUN chmod +x /run.sh

# add volumes for non static
VOLUME ["/etc/puppet/environments"]
VOLUME ["/data"]

CMD ["/run.sh"]