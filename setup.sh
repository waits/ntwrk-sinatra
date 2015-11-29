#! /bin/sh

if [ -e GeoLite2-City.mmdb ]
  then
    rm GeoLite2-City.mmdb
fi
wget "https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz"
gunzip "GeoLite2-City.mmdb.gz"

if [ ! -e public/data ]
  then
    mkdir public/data
fi

if [ ! -e public/data/128mb ]
  then
    dd if=/dev/zero of=public/data/128mb count=128 bs=1000000
fi

exit 0
