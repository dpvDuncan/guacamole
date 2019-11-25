#! /bin/sh
chown -R $PUID:$PGID /config $CATALINA_HOME /opt/guacamole

GROUPNAME=$(getent group $PGID | cut -d: -f1)
USERNAME=$(getent passwd $PUID | cut -d: -f1)

if [ ! $GROUPNAME ]
then
        addgroup -g $PGID medusa
        GROUPNAME=medusa
fi

if [ ! $USERNAME ]
then
        adduser -G $GROUPNAME -u $PUID -D medusa
        USERNAME=medusa
fi

if [ ! ${BASE_URL} ]
        ln -s /opt/guacamole/guacamole.war $CATALINA_HOME/webapps/ROOT.war
else
        ln -s /opt/guacamole/guacamole.war $CATALINA_HOME/webapps/${BASE_URL}.war
fi

su - $USERNAME -c '/opt/guacamole/bin/start.sh'