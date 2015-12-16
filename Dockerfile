FROM centos:centos6
MAINTAINER Gabriele Modena <gm@nowave.it>

ENV PG_VERSION 9.4
ENV PG_CENTOS 94
ENV PG_PORT 5432

RUN rpm -i http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-2.noarch.rpm

RUN yum -y update; yum clean all
RUN yum -y install postgresql$PG_CENTOS postgresql$PG_CENTOS-server postgresql$PG_CENTOS-contrib postgresql$PG_CENTOS-devel postgresql$PG_CENTOS-plpython postgresql$PG_CENTOS-plperl
RUN yum -y install http://bitcast-a.v1.o1.sjc1.bitgravity.com/greenplum/MADlib/files/madlib-1.8-Linux.rpm --nogpgcheck
# required by madlib setup scripts
RUN yum -y install which

ADD ./postgres_user.sh /postgres_user.sh
ADD ./postgres_start.sh /postgres_start.sh
ADD ./madlib_setup.sh /madlib_setup.sh

RUN chmod +x /postgres_user.sh
RUN chmod +x /postgres_start.sh
RUN chmod +x /madlib_setup.sh

RUN service postgresql-$PG_VERSION initdb

RUN echo listen_addresses = \'*\' >> /var/lib/pgsql/$PG_VERSION/data/postgresql.conf
ADD ./pg_hba.conf /var/lib/pgsql/$PG_VERSION/data/pg_hba.conf

RUN /postgres_user.sh
RUN /madlib_setup.sh

EXPOSE $PG_PORT

CMD /postgres_start.sh