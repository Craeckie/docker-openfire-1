# docker-openfire

Docker container for [openfire][3] with [starkweb client][7] include.


"Openfire is a real time collaboration (RTC) server licensed under the Open Source Apache License. It uses the only widely adopted open protocol for instant messaging, XMPP (also called Jabber). Openfire is incredibly easy to setup and administer, but offers rock-solid security and performance."


## Install dependencies

  - [Docker][2]

To install docker in Ubuntu 14.04 use the commands:

    $ sudo apt-get update
    $ wget -qO- https://get.docker.com/ | sh

 To install docker in other operating systems check [docker online documentation][4]

## Usage

If you need a MySQL database you can link container :

    $ docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=mysecretpassword  -e MYSQL_DATABASE=openfire \
    -e MYSQL_USER=openfireuser -e MYSQL_PASSWORD=openfirepasswd -d mysql

in case you want to used pre-existing mysql container , you can add the new database by connecting to it with _docker exec -it some-mysql bash_ and manual add the openfire database or you can link and used quantumobject/docker-mywebsql to create a database openfire with user openfireuser plus you need to grant all permision of this user to the database.  
  
Them link and run the  openfire container:

    $ docker run -d -p 9090:9090 -p 5222:5222 -p 5269:5269 \
    -p 5223:5223 -p 7443:7443 -p 7777:7777 -p 7070:7070 -p 5229:5229 -p 5275:5275 \
    --link some-mysql:db quantumobject/docker-openfire

 or to be able to used with plugins for Jitsi Meet :

    $ docker run -d -p 9090:9090 -p 7443:7443 -p 7777:7777 -p 7070:7070 \
    -p 5000-6000:5000-6000/tcp -p 5000-6000:5000-6000/udp \
    --link some-mysql:db quantumobject/docker-openfire 

where when been ask for database need to replace localhost for db.

See `docker-compose.yml` for use with **Docker-compose**.

## Accessing the openfire applications:

After that check with your browser at addresses plus the port assigined by docker or you:

  - **http://host_ip:9090/**

where MySQL user will be openfireuser with password for the database openfire at db , then need to add email and password for admin account.

When done configuring OpenFire and adding some users you can use the internal web client :

  - **http://host_ip:9090/sparkweb/**

To access the container from the server that the container is running :

    $ docker exec -it container_id /bin/bash

note: -p 5000-6000:5000-6000/tcp -p 5000-6000:5000-6000/udp  this only needed if you going to used plugins for  Openfire Meetings.

## Persistence

To keep the **configuration and plugins** on container removal you can mount the volumes using `-v /host/path/to/config:/etc/openfire -v /host/path/to/plugins:/var/lib/openfire/plugins`
The full command would then be

    $ docker run -d -p 9090:9090 -p 5222:5222 -p 5269:5269 \
      -p 5223:5223 -p 7443:7443 -p 7777:7777 -p 7070:7070 -p 5229:5229 -p 5275:5275 \
      -v /host/path/to/config:/etc/openfire -v /host/path/to/plugins:/var/lib/openfire/plugins \
      --link some-mysql:db quantumobject/docker-openfire
  
To keep the database on removal you can use `-v /path/to/mysql/data:/var/lib/mysql`
The full command would then be

    $ docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=mysecretpassword  -e MYSQL_DATABASE=openfire \
      -e MYSQL_USER=openfireuser -e MYSQL_PASSWORD=openfirepasswd -d \
      -v /path/to/mysql/data:/var/lib/mysql mysql
    
For more information on Volumes see
[docs.docker.com/engine/userguide/containers/dockervolumes/][9]


## More Info

About openfire: [www.igniterealtime.org/projects/openfire/index.jsp][1]

To help improve this container [docker-openfire][5]

Example of this [docker-openfire][6]

For additional info about us and our projects check our site [www.quantumobject.com][8]

[1]:http://www.igniterealtime.org/projects/openfire/index.jsp
[2]:https://www.docker.com
[3]:http://www.igniterealtime.org/downloads/index.jsp
[4]:http://docs.docker.com
[5]:https://github.com/QuantumObject/docker-openfire
[6]:http://www.quantumobject.com:9090
[7]:http://www.igniterealtime.org/projects/sparkweb/index.jsp
[8]:http://www.quantumobject.com/
[9]:https://docs.docker.com/engine/userguide/containers/dockervolumes/
