#!/bin/sh -e

apt-get install libpq-dev

apt-get install python3 python-dev python3-dev \
     build-essential libssl-dev libffi-dev \
     libxml2-dev libxslt1-dev zlib1g-dev \
     python3-pip

pip3 install psycopg2
