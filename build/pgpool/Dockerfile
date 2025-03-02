ARG BASEOS
ARG BASEVER
ARG PG_FULL
ARG PREFIX
FROM ${PREFIX}/radondb-base:${BASEOS}-${PG_FULL}-${BASEVER}

# For RHEL8 all arguments used in main code has to be specified after FROM
ARG DFSET
ARG PACKAGER
ARG BASEOS
ARG PG_MAJOR

LABEL name="pgpool" \
	summary="Contains the pgpool utility as a PostgreSQL-aware load balancer" \
	description="Offers a smart load balancer in front of a Postgres cluster, sending writes only to the primary and reads to the replica(s). This allows an application to only have a single connection point when interacting with a Postgres cluster." \
	io.k8s.description="pgpool II" \
	io.k8s.display-name="pgpool II" \
	io.openshift.tags="postgresql,postgres,pgpool,database,radondb"

RUN ${PACKAGER} -y install \
		pgpool-II-42_${PG_MAJOR//.} \
		pgpool-II-42_${PG_MAJOR//.}-extensions \
	&& ${PACKAGER} -y clean all

# Preserving PGVERSION out of paranoia
ENV PGVERSION="${PG_MAJOR}"

RUN mkdir -p /opt/radondb/bin /opt/radondb/conf

ADD bin/pgpool /opt/radondb/bin
ADD bin/common /opt/radondb/bin
ADD conf/pgpool /opt/radondb/conf

RUN ln -sf /opt/radondb/conf/pool_hba.conf /etc/pgpool-II-42_${PG_MAJOR//.}/pool_hba.conf \
	&& ln -sf /opt/radondb/conf/pgpool/pool_passwd /etc/pgpool-II-42_${PG_MAJOR//.}/pool_passwd

RUN chgrp -R 0 /opt/radondb && \
	chmod -R g=u /opt/radondb


# open up the postgres port
EXPOSE 5432

# add volumes to allow override of pgpool config files
# The VOLUME directive must appear after all RUN directives to ensure the proper
# volume permissions are applied when building the image
VOLUME ["/pgconf"]

# Defines a unique directory name that will be utilized by the nss_wrapper in the UID script
ENV NSS_WRAPPER_SUBDIR="pgpool"

ENTRYPOINT ["opt/radondb/bin/uid_daemon.sh"]

USER 2

CMD ["/opt/radondb/bin/startpgpool.sh"]
