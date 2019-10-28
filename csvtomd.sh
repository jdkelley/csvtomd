#!/usr/bin/env bash

# csvtomd
# version 0.0.2
# Copyright (C) 2019 Joshua D Kelley
# https://github.com/jdkelley/csvtomd"

ME=$(basename "${0}")

# ----------------- Config ----------------

SCRIPT_VERSION="0.0.2"
INSTALL_INSTALL_LOCATION="/usr/local/bin"
CSV_FILENAME=""

# ----------------- Print -----------------

print_version() {
    echo -ne "${SCRIPT_VERSION}\n"
}

print_usage() {
    echo "Usage:"
    echo "  ${ME} [-hv]"
    echo "  ${ME} [subcommand]"
    echo "  ${ME} <csv file to convert>"
    echo
    echo "Description:"
    echo
    echo "   Converts csv file to markdown table (pipe-separated)."
    echo
    echo "The subcommands are as follows:"
    echo "   help       Display help message."
    echo "   version    Prints ${ME} version."
    echo "   install    Installs ${ME}."
    echo "   uninstall  Uninstalls ${ME}."
    echo
    echo "The options are as follows:"
    echo "   -h         Display help message."
    echo "   -v         Prints ${ME} version."
    echo
}

### TODO
# --------- Check for updates -------------

# git archive --remote=${remoteRepo} HEAD ${filename} | tar -x | bash

### TODO
# ---------- Install updates --------------

# ---------------- Install ---------------- 

install_script() {
    echo "Installing as ${INSTALL_LOCATION}/csvtomd"
    cp csvtomd.sh "${INSTALL_LOCATION}"/csvtomd
}

# --------------- Uninstall ---------------

## WARNING - Heads Up! Deletes 1st argument.
delete_script() {
    echo "Deleting  ..."
    rm "$1"
}

cancel_delete_script() {
    echo -e "\nExiting ...\n"
}

print_uninstall_warning_and_uninstall() { 
    echo -e "\nYou are about to remove script:\n\n\t${1}/${ME}\n\n"
    read -r -p "Are you sure? [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            delete_script "${1}/${ME}"
            echo "${1}/${ME} deleted"
            ;;
        *)
            cancel_delete_script
            ;;
    esac
}

uninstall_script() {
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    print_uninstall_warning_and_uninstall "$SCRIPT_DIR"
}

# --------------- Convert --------------- 

remove_csv_ending() {
    local filename="${1}"
    echo "$filename" | sed 's/.csv//'
}

rename_file_csv_to_md() {
    local filename="${1}"
    local trimmedFilename=$(remove_csv_ending "${filename}")
    echo "$trimmedFilename""${addFileEnding}"".md"
}

#  --------------- Init & Main  --------------- 

get_options() {
    local OPTIND opt
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
            uninstall_script
            exit 0
        ;;
    esac

    # Argument did not match a known subcommand so it is the csv file
    CSV_FILENAME="${subcommand}"
}

main() {
    get_options "$@"
    _MD_FILENAME=$(rename_file_csv_to_md "${CSV_FILENAME}")
    
    # Debug
    # echo "_MD_FILENAME:  ${_MD_FILENAME}"
    # echo "_CSV_FILENAME: ${CSV_FILENAME}"

    tr -d '\r' < "${CSV_FILENAME}" \
        | sed 's/,/ | /g' \
        | sed 's/^/|  /'  \
        | sed 's/$/ |/'   \
        | sed 's/SEPARATOR/ :--- /g' > $_MD_FILENAME

    exit 0
}

main "$@"
