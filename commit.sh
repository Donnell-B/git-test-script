function commit() {
    git fetch
    git pull || echo "Git Pull failed -- Please Pull Manually"

    files=$( { git diff --name-only; git diff --name-only --staged; } | sort | uniq )

    if [[ -z $files ]]; then
        echo "No Changes to add"
        exit 0
    fi

    echo "Changed Detected..."
    for file in $files
    do
        echo "Adding $file"
        git add $file
    done
    read -p "Please add a commit message: " commit_msg
    if [[ -z "$commit_msg" ]]; then
        echo "Commit message cannot be empty"
        exit 1
    fi
    git commit -m "$commit_msg"
    git push || { echo "Git push failed"; exit 1; }
}

commit