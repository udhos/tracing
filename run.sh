#!/bin/bash

url=https://github.com/jaegertracing/jaeger/releases/download/v1.22.0/jaeger-1.22.0-linux-amd64.tar.gz

tmp_dir=/tmp/jaeger

mkdir -p $tmp_dir

tgz_base=$(basename $url)
tgz=$tmp_dir/$tgz_base
unpack_dir=$(echo $tgz | sed -e 's/\.tar\.gz//')

download() {
    echo download $url to $tgz
    [ -f $tgz ] || wget -O $tgz $url
}

unpack() {
    [ -f $tgz_dir ] || {
        echo unpack $tgz to $unpack_dir
        download && tar -C $tmp_dir -x -f $tgz
    }
}

unpack

cat <<EOF
# 1. start:
$unpack_dir/jaeger-all-in-one --collector.zipkin.host-port=:9411

# 2. open: http://localhost:16686

# 3. start:
$unpack_dir/example-hotrod all

# 4. open:
http://localhost:8080

EOF

