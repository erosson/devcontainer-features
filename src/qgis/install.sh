#!/bin/sh
set -eu

echo "Activating feature 'qgis'"

# The 'install.sh' entrypoint script is always executed as the root user.
#
# These following environment variables are passed in by the dev container CLI.
# These may be useful in instances where the context of the final 
# remoteUser or containerUser is useful.
# For more details, see https://containers.dev/implementors/features#user-env-var
#echo "The effective dev container remoteUser is '$_REMOTE_USER'"
#echo "The effective dev container remoteUser's home directory is '$_REMOTE_USER_HOME'"
#
#echo "The effective dev container containerUser is '$_CONTAINER_USER'"
#echo "The effective dev container containerUser's home directory is '$_CONTAINER_USER_HOME'"

# https://qgis.org/en/site/forusers/alldownloads.html#linux

mkdir -m755 -p /etc/apt/keyrings  # not needed since apt version 2.4.0 like Debian 12 and Ubuntu 22 or newer
apt-get update
apt-get install -y wget
wget -O /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg
. /etc/os-release
cat ./qgis.sources | sed -s "s/\$VERSION_CODENAME/$VERSION_CODENAME/" | sed -s "s/\$ID/$ID/" > /etc/apt/sources.list.d/qgis.sources
apt-get update
# skips apt-get time zone prompt. https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
DEBIAN_FRONTEND=noninteractive apt-get install -y qgis-server
qgis_mapserver --version