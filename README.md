# centos-postgres-madlib

CentOS 6 dockerfile for PostgreSQL 9.6 and MADlib 1.10 (https://github.com/apache/incubator-madlib).
MADlib is a collection of UDFs for scalable in-database analytics and statistical modeling.



1. This image is available on dockerhub
```
$ docker pull gmodena/centos-pgsql-madlib
```
Alternatively, you can clone the git repo and build with
```
$ ./build.sh
```
2. Run

PostreSQL listens on port 5432 in the container; if port 5432 is open on your host you can run:
```
$ docker run  -dit -p 5432:5432 gmodena/centos-pgsql-madlib
```
otherwise, to assign a random port that maps to 5432 on the container:
```
$ docker run  -dit -p 5432 gmodena/centos-pgsql-madlib
```
You can see the random port the container is listening on with:
```
$ docker ps
```

It might take a while for pgsql to start up. You cam monitor the service status with
```
$ pg_isready -h localhost -p 5432
localhost:5432 - accepting connections
```

3. Usage and test
```
$ psql -h localhost -p 5432 -d maddb -U madlib --password
maddb=# \d
                  List of relations
 Schema |          Name           |   Type   | Owner
--------+-------------------------+----------+--------
 madlib | migrationhistory        | table    | madlib
 madlib | migrationhistory_id_seq | sequence | madlib

```
The default password for this user and database is *password*.


Examples for getting started with MADlib can be found at https://github.com/apache/incubator-madlib/examples/gpce/
