function commit() {
    git fetch
    git pull

    files=$({ git diff --name-only ; git diff --name-only --staged | uniq; })

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

# pull_rebase_setting=$(git config get pull.rebase --local)
# if [[ -z $pull_rebase_setting ]]; then
#     echo "Please set"
# echo $pull_rebase_setting