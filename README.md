centos-postgres-madlib
===========================

CentOS 6 dockerfile for PostgreSQL 9.4 and MADlib 1.8 (https://github.com/apache/incubator-madlib)

MADlib is a collection of UDFs for scalable in-database analytics and statistical modeling.

1.Build

    # docker build -t madlib .

2.Run

PostreSQL listens on port 5432 in the container; if port 5432 is open on your host you can run:

    # docker run  -dit -p 5432:5432 madlib

otherwise, to assign a random port that maps to 5432 on the container:

    # docker run  -dit -p 5432 madlib

You can see the random port the container is listening on with:

    # docker ps

3.Usage

    # psql -h $IP_ADDRESS -p 5432 -d maddb -U madlib --password

The default password for this user and database is *password*.

Examples for getting started with MADlib can be found at
https://github.com/madlib/madlib/tree/master/examples/gpce
