FROM local-dtr.patsnap.com/patsnap/base:latest
MAINTAINER shenyineng<shenyineng@patsnap.com>

RUN yum update -y && \
  yum install -y epel-release && \
  yum install -y varnish && \
  yum install -y libmhash-devel && \
  yum clean all

COPY container_files /

ENV VCL_CONFIG      /etc/varnish/default.vcl
ENV CACHE_SIZE      64m
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600

RUN chmod 755 /config/init/bootstrap.sh
EXPOSE 8080