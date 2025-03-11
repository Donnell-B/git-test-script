function commit() {
    git fetch
    git pull

    files=$({ git diff --name-only ; git diff --name-only --staged ; })

    if [[ -z $files ]]; then
        echo "No Changes to add"
        exit
    fi

    echo "Changed Detected..."
    for file in $files
    do
        echo "Adding $file"
        git add $file
    done
    read -p "Please add a commit message: " commit_msg
    git commit -m "$commit_msg"
    git push
}

commit