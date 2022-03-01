#!/bin/bash
rm -rf ./build/static
rm -rf ./build/views
rm -rf ./build/mindoc_linux_x86_64.*
VSERION="v$(date +%Y%m%d)"
go build -o ./build/mindoc_linux_x86_64.${VSERION}.bin main.go
cp -r static ./build/
cp -r views  ./build/
cd ./build
tar zcvf mindoc_linux_x86_64.${VSERION}.tar.gz ./


