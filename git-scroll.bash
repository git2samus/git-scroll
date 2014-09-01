#!/bin/bash

# get current branch to rollback when done
while read line; do
    if [[ $line == \** ]]; then
        restore_branch=${line#* }
        break
    fi
done < <(git branch)

# set automatic rollback
trap 'git checkout "$restore_branch"' 0

# save list of revisions/messages to navigate
revisions=() messages=()
while read rev msg; do
    revisions+=("$rev") messages+=("$msg")
done < <(git log --reverse --oneline -- "$1")

# navigate
current=0
while true; do
    # update working-tree
    git checkout "${revisions[$current]}" || exit

    # print list and position
    clear
    for ((i=0; i<"${#messages[@]}"; i++)); do
        if ((i == current)); then
            echo -n "* "
        else
            echo -n "  "
        fi
        echo "${messages[$i]}"
    done
    echo

    # query next action
    select action in prev next quit; do
        case "$action" in
            prev)
                if ((current == 0)); then
                    echo "Already on first revision"; read
                else
                    let "current--"
                fi;;
            next)
                if ((current == ${#revisions[@]} - 1)); then
                    echo "Already on last revision"; read
                else
                    let "current++"
                fi;;
            quit)
                exit
                ;;
            *)
                continue
        esac
        break
    done
done
