#!/usr/bin/env bash

SCRIPT_NAME="${0}"
FILE=$1

# ----------------- Flags ----------------- 

# addFileEnding
# Seperator

# ----------------- Config ----------------

# Template script config

# --------- Check for updates -------------

# git archive --remote=${remoteRepo} HEAD ${filename} | tar -x | bash

# ---------- Install updates --------------

# ---------------- Install ---------------- 

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
    #uninstall_script
    convertCSVToMDtoTable $FILE
}

main
