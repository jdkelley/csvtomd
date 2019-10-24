#!/usr/bin/env bash

SCRIPT_NAME="${0}"
ME=$(basename "${0}")

# ----------------- Config ----------------

SCRIPT_VERSION="0.0.1"

# ----------------- Print -----------------

function print_version() {
    echo -e "csvtomd, version ${SCRIPT_VERSION}\nCopyright (C) 2019 Joshua D Kelley\nhttps://github.com/jdkelley/csvtomd"
}

function print_usage() {
    echo "Usage:"
    echo "  ${ME} [-hv] [subcommand] <csv file to convert>"
    echo
    echo "Description:"
    echo
    echo "   some text here"
    echo
    echo "The subcommands are as follows:"
    echo "   help       Display help message."
    echo "   version    Prints ${ME} version."
    echo "   install    Installs ${ME}."
    echo "   uninstall  Uninstalls ${ME}."
    echo
    echo "The options are as follows:"
    echo "   -h,-H Display help message."
    echo "   -v,-V Prints ${ME} version."
    echo -e "\n\n"
}

### TODO
# --------- Check for updates -------------

# git archive --remote=${remoteRepo} HEAD ${filename} | tar -x | bash

### TODO
# ---------- Install updates --------------

# ---------------- Install ---------------- 

function install_script {
    local LOCATION="/usr/local/bin"
    echo "Installing as ${LOCATION}/csvtomd"
    cp csvtomd.sh "${LOCATION}"/csvtomd
}

# --------------- Uninstall ---------------

## WARNING - Heads Up! Deletes 1st argument.
function delete_script {
    echo -e "\Deleting  ...\n"
    rm "$1"
}

function cancel_delete_script {
    echo -e "\nExiting ...\n"
}

function print_uninstall_warning_and_uninstall { 
    echo -e "\nYou are about to remove script:\n\n\t${1}/${SCRIPT_NAME}\n\n"
    read -r -p "Are you sure? [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            # comment out for safety for right now. 
            # delete_script
            echo "You chose delete_script"
            ;;
        *)
            cancel_delete_script
            ;;
    esac
}

function uninstall_script {
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    print_uninstall_warning_and_uninstall "$SCRIPT_DIR"
}

# --------------- Convert --------------- 

function removeCSVEnding {
    local filename="${1}"
    echo "$filename" | sed 's/.csv//'
}

function renameFileCSVToMD {
    local filename="${1}"
    local trimmedFilename=$(removeCSVEnding "${filename}")
    echo "$trimmedFilename""${addFileEnding}"".md"
}

function convertCSVToMDtoTable {
    local filename="${1}"
    mdFilename=$(renameFileCSVToMD "${filename}")
    echo "${mdFilename}"

    tr -d '\r' < "${filename}" \
        | sed 's/,/ | /g' \
        | sed 's/^/|  /'  \
        | sed 's/$/ |/'   \
        | sed 's/SEPARATOR/ :--- /g' > $mdFilename
}

#  --------------- Main  --------------- 

function main {
    file_to_convert="${1}"
    convertCSVToMDtoTable "$file_to_convert"
}

# ----------------- Flags ----------------- 

while getopts ":hHvV" opt; do
    case "${opt}" in
        [vV] )
            print_version
            exit 0
        ;;
        [hH] )
            print_usage
            exit 0
        ;;
        \? ) 
            print_usage
            exit 1
        ;;
    esac
done

# shift command and drop first arg.
subcommand="${1}"
shift 

echo "subcommand: $subcommand"
case "${subcommand}" in
    [hH][eEaA][lL][pP] )
        print_usage
        exit 0
    ;;
    [vV][eE][rR][sS][iI][oO][nN] )
        print_version
        exit 0
    ;;
    install )
        install_script
        exit 0
    ;;
    uninstall )
        print_uninstall_warning_and_uninstall
        exit 0
    ;;
esac

# Argument did not match a known subcommand so it is the csv file
csv_file="${subcommand}"

main "${csv_file}"
