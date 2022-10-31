FROM instantlinux/nagios:latest

ENV NG_VERSION=1.5.2

RUN cd /tmp && \
    apk add --update --no-cache perl-rrd perl-gd perl-cgi py3-requests font-liberation && \
    wget -qO - https://sourceforge.net/projects/nagiosgraph/files/nagiosgraph/${NG_VERSION}/nagiosgraph-${NG_VERSION}.tar.gz/download | tar -xz

ENV NG_CGI_DIR=/usr/lib/nagios/cgi-bin
ENV NG_LAYOUT=custom
ENV NG_PREFIX=/usr/local/nagiosgraph
ENV NG_ETC_DIR=/etc/nagios/nagiosgraph
ENV NG_BIN_DIR=/usr/local/nagiosgraph/libexec
ENV NG_DOC_DIR=/usr/local/nagiosgraph/docs
ENV NG_EXAMPLES_DIR=/usr/local/nagiosgraph/docs/examples
ENV NG_WWW_DIR=/usr/local/nagiosgraph/share
ENV NG_UTIL_DIR=/usr/local/nagiosgraph/docs/util
ENV NG_VAR_DIR=/var/nagios
ENV NG_RRD_DIR=/var/nagios/nagiosgraph/rrd
ENV NG_LOG_DIR=/var/nagios/nagiosgraph/logs
ENV NG_LOG_FILE=/var/nagios/nagiosgraph/logs/ng.log
ENV NG_CGILOG_FILE=/var/nagios/nagiosgraph/logs/cgi.log
ENV NG_CGI_URL=/cgi-bin
ENV NG_NAGIOS_CGI_URL=/cgi-bin
ENV NG_CSS_URL=/nagiosgraph/
ENV NG_JS_URL=/nagiosgraph/
ENV NG_NAGIOS_PERFDATA_FILE=/var/nagios/service-perfdata
ENV NG_NAGIOS_USER=nagios
ENV NG_WWW_USER=www-data
ENV NG_MODIFY_NAGIOS_CONFIG=n
ENV NG_NAGIOS_CONFIG_FILE=/etc/nagios/nagios.cfg
ENV NG_NAGIOS_COMMANDS_FILE=/etc/nagios/objects/commands.cfg
ENV NG_MODIFY_APACHE_CONFIG=n

RUN cd /tmp/nagiosgraph-${NG_VERSION}
   &&  ./install.pl --install || /bin/true
RUN cd /tmp
   &&  rm -Rf nagiosgraph
   
