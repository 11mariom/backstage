#!/bin/bash

TMPRT="/tmp/rootfs"
FNAME="$(date +%Y-%m-%d_%H%M).tar.bz2"
CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p ${TMPRT}
mount /dev/root ${TMPRT}

cd ${TMPRT}
tar cvjf /home/stage4/${FNAME} ./ -X ${CURDIR}/stage4.excl
cd ${CURDIR}

umount ${TMPRT}
