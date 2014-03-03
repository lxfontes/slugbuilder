#!/bin/sh
export LC_ALL=C
export DEBIAN_FRONTEND=noninteractive
minimal_apt_get_install='apt-get install -y --no-install-recommends'
INSTPATH=/slugbuilder

${minimal_apt_get_installer} pigz

gem install bundler --no-ri --no-rdoc

mkdir -p ${INSTPATH}/buildpacks
cd ${INSTPATH}/buildpacks && xargs -L 1 git clone --depth=1 < ${INSTPATH}/buildpacks.txt
cd ${INSTPATH} && bundle install


rm -f /slugbuilder/setup.sh /slugbuilder/buildpacks.txt
