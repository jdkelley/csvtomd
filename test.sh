#!/usr/bin/env bash

SCRIPT_NAME="${0}"
ME=$(basename "${0}")
# FILE=$1

# ----------------- Config ----------------

SCRIPT_VERSION="0.0.1"

# ----------------- Supporting ----------------

version () {
    echo "dude"
    echo -e "csvtomd, version ${SCRIPT_VERSION}\nCopyright (C) 2019 Joshua D Kelley (@jdkelley)"
}

function usage {
    echo "Usage:"
    echo "  ${ME} [-hv] <subcommand> [-w spprod00 | spprod01 | spprod02 | sptest00 | bgprod00] "
    echo
    echo "Description:"
    echo
    echo "   some text here"
    echo
    echo "The subcommands are as follows:"
    echo "   help       Display help message."
    echo "   version    Prints ${ME} version."
    echo "   install    Installs ${ME} version."
    echo
    echo "The options are as follows:"
    echo "   -h,-H Display help message."
    echo "   -v,-V Prints ${ME} version."
    echo "   -w    Selects swarm to deploy to (push to dtr and deploy stack)."
    echo "         Possible values:"
    echo "                     - spprod00"
    echo "                     - spprod01"
    echo "                     - spprod02"
    echo "                     - sptest00"
    echo "                     - bgprod00"
    echo -e "\n\n"
}


while getopts ":hHvV" opt; do
    case "${opt}" in
        [vV] )
            version
            exit 0
        ;;
        [hH] )
            usage
            exit 0
        ;;
        \? ) 
            usage
            exit 1
        ;;
    esac
done


echo finished

init() {