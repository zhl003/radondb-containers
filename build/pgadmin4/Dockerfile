ARG BASEOS
ARG BASEVER
ARG PG_FULL
ARG PREFIX
FROM ${PREFIX}/radondb-base:${BASEOS}-${PG_FULL}-${BASEVER}

# For RHEL8 all arguments used in main code has to be specified after FROM
ARG BASEOS
ARG PACKAGER
ARG PG_MAJOR

# Needed due to lack of environment substitution trick on ADD
ARG PG_LBL

LABEL name="pgadmin4" \
	summary="pgAdmin4 GUI utility" \
	description="Provides GUI for the pgAdmin 4 utility." \
	io.k8s.description="pgadmin4 container" \
	io.k8s.display-name="pgAdmin 4" \
	io.openshift.tags="postgresql,postgres,monitoring,pgadmin4,pgadmin,database,radondb"

RUN mkdir -p /opt/radondb/bin /opt/radondb/conf /var/lib/pgadmin /var/log/pgadmin \
        /certs /run/httpd

RUN if [ "$BASEOS" = "centos7" ] ; then \
        ${PACKAGER} -y install \
                --setopt=skip_missing_names_on_install=False \
                mod_ssl \
                mod_wsgi \
                openssl \
                --setopt=obsoletes=0 pgadmin4 \
                postgresql${PG_MAJOR//.}-server \
        && ${PACKAGER} -y clean all  \
        && chown -R 2:0 /usr/lib/python3.6/site-packages/pgadmin4-web \
                /var/lib/pgadmin /var/log/pgadmin /certs /etc/httpd /run/httpd \
                /var/log/httpd \
        && chmod -R g=u /usr/lib/python3.6/site-packages/pgadmin4-web \
                /var/lib/pgadmin /var/log/pgadmin /certs /etc/httpd /run/httpd /var/log/httpd \
        && ln -sf /var/lib/pgadmin/config_local.py /usr/lib/python3.6/site-packages/pgadmin4-web/config_local.py \
        && ln -sf /var/lib/pgadmin/pgadmin.conf /etc/httpd/conf.d/pgadmin.conf ; \
fi

RUN if [ "$BASEOS" = "centos8" ] ; then \
        ${PACKAGER} -y install \
                --setopt=skip_missing_names_on_install=False \
                mod_ssl \
                python3-mod_wsgi \
                openssl \
                sqlite \
                --setopt=obsoletes=0 pgadmin4 \
                postgresql${PG_MAJOR//.}-server \
        && ${PACKAGER} -y clean all \
        && chown -R 2:0 /usr/lib/python3.6/site-packages/pgadmin4-web \
                /var/lib/pgadmin /var/log/pgadmin /certs /etc/httpd /run/httpd \
                /var/log/httpd \
        && chmod -R g=u /usr/lib/python3.6/site-packages/pgadmin4-web \
                /var/lib/pgadmin /var/log/pgadmin /certs /etc/httpd /run/httpd /var/log/httpd \
        && ln -sf /var/lib/pgadmin/config_local.py /usr/lib/python3.6/site-packages/pgadmin4-web/config_local.py \
        && ln -sf /var/lib/pgadmin/pgadmin.conf /etc/httpd/conf.d/pgadmin.conf \
        && alternatives --set python /usr/bin/python3 ; \
fi

RUN if [ "$BASEOS" = "ubi7" ] ; then \
        ${PACKAGER} -y install \
                --setopt=skip_missing_names_on_install=False \
                --enablerepo="epel,rhel-7-server-extras-rpms" \
                mod_ssl \
                mod_wsgi \
                openssl \
                --setopt=obsoletes=0 pgadmin4 \
                postgresql${PG_MAJOR//.}-server \
        && ${PACKAGER} -y clean all --enablerepo="epel,rhel-7-server-extras-rpms" \
        && chown -R 2:0 /usr/lib/python3.6/site-packages/pgadmin4-web \
                /var/lib/pgadmin /var/log/pgadmin /certs /etc/httpd /run/httpd \
                /var/log/httpd \
        && chmod -R g=u /usr/lib/python3.6/site-packages/pgadmin4-web \
                /var/lib/pgadmin /var/log/pgadmin /certs /etc/httpd /run/httpd /var/log/httpd \
        && ln -sf /var/lib/pgadmin/config_local.py /usr/lib/python3.6/site-packages/pgadmin4-web/config_local.py \
        && ln -sf /var/lib/pgadmin/pgadmin.conf /etc/httpd/conf.d/pgadmin.conf ; \
fi

RUN if [ "$BASEOS" = "ubi8" ] ; then \
        ${PACKAGER} -y install \
                --enablerepo="epel" \
                mod_ssl \
                python3-mod_wsgi \
                openssl \
                sqlite \
                pgadmin4 \
                postgresql${PG_MAJOR//.}-server \
        && ${PACKAGER} -y clean all --enablerepo="epel" \
        && chown -R 2:0 /usr/lib/python3.6/site-packages/pgadmin4-web \
                /var/lib/pgadmin /var/log/pgadmin /certs /etc/httpd /run/httpd \
                /var/log/httpd \
        && chmod -R g=u /usr/lib/python3.6/site-packages/pgadmin4-web \
                /var/lib/pgadmin /var/log/pgadmin /certs /etc/httpd /run/httpd /var/log/httpd \
        && ln -sf /var/lib/pgadmin/config_local.py /usr/lib/python3.6/site-packages/pgadmin4-web/config_local.py \
        && ln -sf /var/lib/pgadmin/pgadmin.conf /etc/httpd/conf.d/pgadmin.conf \
        && alternatives --set python /usr/bin/python3 ; \
fi

# Preserving PGVERSION out of paranoia
ENV PGROOT="/usr/pgsql-${PG_MAJOR}" PGVERSION="${PG_MAJOR}"

ADD bin/pgadmin4/ /opt/radondb/bin
ADD bin/common /opt/radondb/bin
ADD conf/pgadmin4/ /opt/radondb/conf

RUN cp /opt/radondb/conf/httpd.conf /etc/httpd/conf/httpd.conf \
	&& rm /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/ssl.conf

EXPOSE 5050

# The VOLUME directive must appear after all RUN directives to ensure the proper
# volume permissions are applied when building the image
VOLUME ["/var/lib/pgadmin", "/certs", "/run/httpd"]

# Defines a unique directory name that will be utilized by the nss_wrapper in the UID script
ENV NSS_WRAPPER_SUBDIR="pgadmin"

ENTRYPOINT ["opt/radondb/bin/uid_daemon.sh"]

USER 2

CMD ["/opt/radondb/bin/start-pgadmin4.sh"]
