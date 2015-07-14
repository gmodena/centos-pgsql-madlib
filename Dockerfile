FROM centos:centos6
MAINTAINER Gabriele Modena <gm@nowave.it>

RUN rpm -i http://yum.postgresql.org/9.2/redhat/rhel-6-x86_64/pgdg-centos92-9.2-6.noarch.rpm
RUN yum -y update; yum clean all
RUN yum -y install postgresql92 postgresql92-server postgresql92-contrib postgresql92-devel postgresql92-plpython postgresql92-plperl
RUN yum -y install http://bitcast-a.v1.o1.sjc1.bitgravity.com/greenplum/MADlib/files/madlib-1.7.1-Linux.rpm --nogpgcheck
# required by madlib setup scripts
RUN yum -y install which

ADD ./postgres_user.sh /postgres_user.sh
ADD ./postgres_start.sh /postgres_start.sh
ADD ./madlib_setup.sh /madlib_setup.sh

RUN chmod +x /postgres_user.sh
RUN chmod +x /postgres_start.sh
RUN chmod +x /madlib_setup.sh

RUN service postgresql-9.2 initdb

RUN echo listen_addresses = \'*\' >> /var/lib/pgsql/9.2/data/postgresql.conf
ADD ./pg_hba.conf /var/lib/pgsql/9.2/data/pg_hba.conf

RUN /postgres_user.sh
RUN /madlib_setup.sh

EXPOSE 5432

CMD /postgres_start.sh