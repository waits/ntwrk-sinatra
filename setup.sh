#! /bin/sh

if [ -e GeoLite2-City.mmdb ]
  then
    rm GeoLite2-City.mmdb
fi
wget "https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz"
gunzip "GeoLite2-City.mmdb.gz"

if [ ! -e public/test ]
  then
    mkdir public/test
fi

if [ ! -e public/test/download ]
  then
    dd if=/dev/zero of=public/test/download count=128 bs=1000000
fi

exit 0
