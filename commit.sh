function commit() {
    files=$({ git diff --name-only ; git diff --name-only --staged ; })
    for file in $files
    do
        echo $file
    done
}

commit

# git diff --name-only --cached

# function hello() {
#     echo "Hello World"
# }
# hello