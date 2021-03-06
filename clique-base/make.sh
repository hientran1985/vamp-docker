#!/usr/bin/env bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

reset=`tput sgr0`
green=`tput setaf 2`
yellow=`tput setaf 3`

target=$1
go_dir=${target}/go

revision=f57fe6c

bin='vamp-gateway-agent'
export GOOS='linux'
export GOARCH='amd64'
mkdir -p ${go_dir}
export GOPATH=${go_dir}

echo "${green}Cloning Vamp Gateway Agent to ${target}...${reset}"
mkdir -p ${go_dir}/src/github.com && cd ${go_dir}/src/github.com
git clone git@github.com:magneticio/vamp-gateway-agent.git
cd ${go_dir}/src/github.com/vamp-gateway-agent && git checkout ${revision} .

echo "${green}Building ${GOOS}:${GOARCH} ${yellow}${bin}${reset}"
go get github.com/tools/godep
godep restore
go install
CGO_ENABLED=0 go build -v -a -installsuffix cgo

echo "${green}copying files...${reset}"
mkdir -p ${target}/haproxy
cp ./haproxy/1.6.4/haproxy.basic.cfg ${target}/haproxy/
cp ./reload.sh ${target}/haproxy/
cp ./validate.sh ${target}/haproxy/
cp ./${bin} ${target}/ && chmod u+x ${target}/${bin}
cd ${dir} && rm -Rf ${go_dir}
cp -f ${dir}/Dockerfile ${target}/Dockerfile
cp -Rf ${dir}/elasticsearch ${target}/
cp -Rf ${dir}/logstash ${target}/
cp -Rf ${dir}/kibana ${target}/
cp -f ${dir}/supervisord.conf ${target}/supervisord.conf


