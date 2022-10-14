FROM instantlinux/nagios:latest

ENV NAGIOS_HOME            /var/nagios
ENV NG_NAGIOS_CONFIG_FILE  /etc/nagios/nagios.cfg
ENV NG_CGI_DIR             ${NAGIOS_HOME}/sbin
ENV NG_WWW_DIR             ${NAGIOS_HOME}/share/nagiosgraph
ENV NG_VERSION             1.5.2

RUN cd /tmp                                                          && \
    wget -qO - https://sourceforge.net/projects/nagiosgraph/files/nagiosgraph/${NG_VERSION}/nagiosgraph-${NG_VERSION}.tar.gz/download | tar -xz && \
    cd nagiosgraph-${NG_VERSION}                                                  && \
    ./install.pl --install                                      \
        --prefix /var/nagiosgraph                               \
        --etc-dir /etc/nagios/nagiosgraph                       \
        --nagios-user ${NAGIOS_USER}                            \
        --www-user ${NAGIOS_USER}                               \
        --nagios-perfdata-file ${NAGIOS_HOME}/var/perfdata.log  \
        --nagios-cgi-url /cgi-bin                               \
                                                                     && \
    cp share/nagiosgraph.ssi ${NAGIOS_HOME}/share/ssi/common-header.ssi && \
    cd /tmp && rm -Rf nagiosgraph
