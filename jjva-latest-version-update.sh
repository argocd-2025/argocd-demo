#!/bin/bash
imageVersion="eagunuworld/jjva-mss-java-web-app:v$BUILD_NUMBER"
sed -i "s#cicd_latest_version#${imageVersion}#g" jjva-manifest.yml
cat jjva-manifest.yml |grep  'eagunu'
