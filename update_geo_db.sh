#! /bin/sh

if [ -e GeoLite2-City.mmdb ]
  then
    rm GeoLite2-City.mmdb
fi
wget "https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz"
gunzip "GeoLite2-City.mmdb.gz"

exit 0
