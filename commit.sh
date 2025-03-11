function commit() {
    git_status=$( git status 2>&1)
    if [[ "$git_status" == *"fatal: not a git repository"* ]]; then
        echo "Not in a Git Repository! Exiting"
        return 1
    fi

    git fetch
    git pull || { echo "Git Pull failed -- Please Pull Manually"; return 1; }

    tracked_files=$( git ls-files -z )
    if [[ -z $tracked_files ]]; then
        echo "You have no tracked files!"
        echo "Add all files (.) now? (Y/N)"
        read choice
        if [[ $choice == 'Y' || $choice == 'y' ]]; then
            git add .
            git commit -m "Tracking initial files"
            git push
            echo "Files added, committed, and pushed successfully."
            return 0
        else
            echo "No files added. Please do it manually. Exiting."
            return 1
        fi
    fi

    files=$( { git diff --name-only; git diff --name-only --staged; } | sort | uniq )

    if [[ -z $files ]]; then
        echo "No Changes to add"
        return 0
    fi

    echo "Changed Detected..."
    for file in $files
    do
        echo "Staged: $file"
        git add $file
    done
    read -p "Please add a commit message: " commit_msg
    if [[ -z "$commit_msg" ]]; then
        echo "Commit message cannot be empty"
        return 1
    fi
    git commit -m "$commit_msg"
    git push || { echo "Git push failed"; return 1; }
}

commit