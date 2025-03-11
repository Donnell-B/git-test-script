function commit() {
    files=$({ git diff --name-only ; git diff --name-only --staged ; })
    for file in $files
    do
        git add $file
    done
    read -p "Please add a commit message: " commit_msg
    echo $commit_msg
    git commit -m $commit_msg
    git push
}

commit
#something here
# git diff --name-only --cached

# function hello() {
#     echo "Hello World"
# }
# hello