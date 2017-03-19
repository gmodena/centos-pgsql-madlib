FROM centos:centos6
MAINTAINER Gabriele Modena <gm@nowave.it>
ARG PG_VERSION=${PG_VERSION}
ARG PG_MINOR=${PG_MINOR}
ARG PG_CENTOS=${PG_CENTOS}
ARG PG_PORT=${PG_PORT}
ARG PG_PGDG_VERSION=${PG_PGDG_VERSION}
ARG MADLIB_VERSION=${MADLIB_VERSION}

ADD ./postgres_start.sh /postgres_start.sh
ADD ./madlib_setup.sh /madlib_setup.sh
ADD ./env.sh /env.sh


RUN chmod +x /postgres_start.sh
RUN chmod +x /madlib_setup.sh

RUN yum -y update; yum clean all

RUN rpm -i https://yum.postgresql.org/${PG_VERSION}/redhat/rhel-6-x86_64/pgdg-centos${PG_CENTOS}-${PG_PGDG_VERSION}.noarch.rpm

RUN yum -y install which gcc make python-setuptools gcc-c++ cmake m4 postgresql${PG_CENTOS} postgresql${PG_CENTOS}-server postgresql${PG_CENTOS}-contrib postgresql${PG_CENTOS}-devel postgresql${PG_CENTOS}-plpython postgresql${PG_CENTOS}-plperl

# It looks like the madlib 1.10-0 rpm does not ship with some of 
# of the pgsql modules. We'll have to build things from source.
#RUN yum -y install https://dist.apache.org/repos/dist/release/incubator/madlib/$MADLIB_VERSION-incubating//apache-madlib-$MADLIB_VERSION-incubating-bin-Linux.rpm --nogpgcheck
 
RUN service postgresql-$PG_VERSION initdb
RUN echo listen_addresses = \'*\' >> /var/lib/pgsql/$PG_VERSION/data/postgresql.conf
ADD ./pg_hba.conf /var/lib/pgsql/$PG_VERSION/data/pg_hba.conf

# Download and build madlib via pgxn (https://pgxn.org)
RUN easy_install pgxnclient
ENV PATH="/usr/pgsql-${PG_VERSION}/bin/:${PATH}"
RUN pgxn install "madlib=${MADLIB_VERSION}"

RUN /madlib_setup.sh

EXPOSE $PG_PORT

CMD /postgres_start.sh
