# Basics
#
#
FROM dockerfile/ubuntu
MAINTAINER polohb <polohb@gmail.com>

ENV TS_VERSION 3.0.11.2
ENV TS_HOME /opt/ts3

# Update system and install some package
RUN apt-get update -y \
&& apt-get install -q -y curl \
&& rm -rf /var/lib/apt/lists/*


# Prepare folders download and extract ts3 server
RUN curl -Lks http://dl.4players.de/ts/releases/${TS_VERSION}/teamspeak3-server_linux-amd64-${TS_VERSION}.tar.gz -o /tmp/ts3.tar.gz \
&& tar zxf /tmp/ts3.tar.gz -C /opt \
&& mv /opt/teamspeak3-server_linux-amd64/ ${TS_HOME} \
&& rm -rf /tmp/ts3.tar.gz

# Add launch script
ADD run.sh ${TS_HOME}/run.sh

# /start runs it.
EXPOSE 9987/udp
EXPOSE 10011
EXPOSE 30033

VOLUME ["/ts3-data"]
CMD    ["/opt/ts3/run.sh"]
