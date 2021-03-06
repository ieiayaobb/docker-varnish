FROM local-dtr.patsnap.com/patsnap/base:latest
MAINTAINER shenyineng <shenyineng@patsnap.com>

RUN yum swap -y -- remove systemd-container\* -- install systemd systemd-libs && \
  yum update -y && \
  yum install -y epel-release && \
  yum install -y varnish && \
  yum install -y libmhash-devel && \
  yum clean all

ADD start.sh /start.sh

ENV VCL_CONFIG      /etc/varnish/default.vcl
ENV CACHE_SIZE      64m
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600

CMD /start.sh
EXPOSE 80
