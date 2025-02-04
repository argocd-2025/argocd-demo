#!/bin/bash
imageVersion="eagunuworld/jjva-mss-java-web-app:v$BUILD_NUMBER"
ls -lart
pwd
cd /home/makutaworldmpm/jjva-GloudConnectworkingDirectory/workspace/argocd-project/argocd-jjva-web-app/jjva-web-app
sed -i "s#cicd_latest_version#${imageVersion}#g" jjva-web-pod-manifest.yml
cat jjva-web-pod-manifest.yml |grep  'eagunu'
