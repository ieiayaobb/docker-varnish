#!/bin/bash

export PROJECT=project-varnish
export RELEASE_VERSION=Rel.1.0.0
export LOCAL_DTR_URL=local-dtr.patsnap.com
export CN_DTR_URL=docker-registry.patsnap.com
export JP_DTR_URL=docker-registry-jp.patsnap.com

docker_images=`(docker images | grep ${PROJECT}| awk '{print $3}')`
#docker rmi -f ${docker_images} > /dev/null 2>&1


docker tag ${LOCAL_DTR_URL}/patsnap/${PROJECT}:${RELEASE_VERSION} ${CN_DTR_URL}/patsnap/${PROJECT}:${RELEASE_VERSION}-${BUILD_NUMBER}

docker login -u dtr -p patsnapDTR ${CN_DTR_URL}

docker push ${CN_DTR_URL}/patsnap/${PROJECT}:${RELEASE_VERSION}-${BUILD_NUMBER}


docker tag ${LOCAL_DTR_URL}/patsnap/${PROJECT}:${RELEASE_VERSION} ${JP_DTR_URL}/patsnap/${PROJECT}:${RELEASE_VERSION}-${BUILD_NUMBER}

docker login -u devops@patsnap.com -p patsnapADMIN2015 -e devops@patsnap.com ${JP_DTR_URL}

docker push ${JP_DTR_URL}/patsnap/${PROJECT}:${RELEASE_VERSION}-${BUILD_NUMBER}