#!/bin/bash
###########
# backshot
# 
# rdiff-backup + stage-4 backup

help() {
    cat <<EOF
backhost requires options:
-h        this help
-c conf   loads config file
EOF
}

while getopts ":c:h" opt; do
    case $opt in
	c)
	    source $OPTARG
	    ;;
	h)
	    help
	    ;;
	\?)
	    help
	    ;;
	:)
	    echo "-$OPTARG requires arg"
	    ;;
    esac
done

EXCLUDE=$( echo ${EXCLUDE} | awk '{for (i = 1; i <= NF; i++)\
                                  printf "--exclude %s ",$i}')

if [[ -n ${RHOST} ]]; then
    DESTDIR="${RHOST}::${DESTDIR}"
fi

rdiff-backup ${RDIFFOPT} ${EXCLUDE} ${SRCDIR} ${DESTDIR}

if [[ -n ${MAXTIME} ]]; then
    rdiff-backup --remove-older-than ${MAXTIME} ${DESTDIR}
fi
