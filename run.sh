#!/bin/bash

##
# FileName : run.sh
#
# Author :  polohb@gmail.com
#
# Desc : startup file for teamspeak in a docker container
#
##

VOLUME=/ts3-data

# Checking if files exist to make sure we're backing up the database to data
if [ ! -f ${TS_HOME}/ts3server.sqlitedb ] && [ -f ${VOLUME}/ts3server.sqlitedb ]
then
    ln -s ${VOLUME}/ts3server.sqlitedb ${TS_HOME}/ts3server.sqlitedb
fi

if [ -f ${TS_HOME}/ts3server.sqlitedb ] && [ ! -f ${VOLUME}/ts3server.sqlitedb ]
then
    mv ${TS_HOME}/ts3server.sqlitedb ${VOLUME}/ts3server.sqlitedb
    ln -s ${VOLUME}/ts3server.sqlitedb ${TS_HOME}/ts3server.sqlitedb
fi

if [ -f ${TS_HOME}/ts3server.sqlitedb ] && [ -f /data/ts3server.sqlitedb ]
then
    rm ${TS_HOME}/ts3server.sqlitedb
    ln -s ${VOLUME}/ts3server.sqlitedb ${TS_HOME}/ts3server.sqlitedb
fi


# Run the teamspeak server
export LD_LIBRARY_PATH=${TS_HOME}
cd ${TS_HOME}
./ts3server logpath=${VOLUME}/logs/
