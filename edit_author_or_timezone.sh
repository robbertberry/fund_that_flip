# Function to change author and email
change_author_email() {
    read -p "Enter your old email address: " OLD_EMAIL
    read -p "Enter your correct name: " CORRECT_NAME
    read -p "Enter your correct email address: " CORRECT_EMAIL

    git filter-branch -f --env-filter "
    OLD_EMAIL=\"$OLD_EMAIL\"
    CORRECT_NAME=\"$CORRECT_NAME\"
    CORRECT_EMAIL=\"$CORRECT_EMAIL\"
    if [ \"\$GIT_COMMITTER_EMAIL\" = \"\$OLD_EMAIL\" ]
    then
        export GIT_COMMITTER_NAME=\"\$CORRECT_NAME\"
        export GIT_COMMITTER_EMAIL=\"\$CORRECT_EMAIL\"
    fi
    if [ \"\$GIT_AUTHOR_EMAIL\" = \"\$OLD_EMAIL\" ]
    then
        export GIT_AUTHOR_NAME=\"\$CORRECT_NAME\"
        export GIT_AUTHOR_EMAIL=\"\$CORRECT_EMAIL\"
    fi
    " --tag-name-filter cat -- --branches --tags
}

# Function to change time zone
change_time_zone() {
    read -p "Enter the target time zone (e.g., -0800, +0400): " TARGET_TIMEZONE

    git filter-branch -f --env-filter "
    export GIT_COMMITTER_DATE=\$(echo \$GIT_COMMITTER_DATE | sed -E 's/[+-][0-9]{4}/$TARGET_TIMEZONE/')
    export GIT_AUTHOR_DATE=\$(echo \$GIT_AUTHOR_DATE | sed -E 's/[+-][0-9]{4}/$TARGET_TIMEZONE/')
    " --tag-name-filter cat -- --branches --tags
}

# Function to change commit date
change_commit_date() {
    read -p "Enter the commit hash: " COMMIT_HASH
    read -p "Enter the target date (e.g., 'Wed Jul 19 14:15:37 2023'): " TARGET_DATE

    git filter-branch -f --env-filter "
    if [ \$GIT_COMMIT = $COMMIT_HASH ]
    then
        export GIT_COMMITTER_DATE=\"$TARGET_DATE\"
        export GIT_AUTHOR_DATE=\"$TARGET_DATE\"
    fi
    " --tag-name-filter cat -- --branches --tags
}

# Display the menu and execute the selected option
while true; do
    echo "Menu:"
    echo "a - Change author and email"
    echo "b - Change time zone"
    echo "c - Change commit date and year"
    echo "q - Quit"

    read -p "Enter your choice: " choice

    case $choice in
        a)
            change_author_email
            ;;
        b)
            change_time_zone
            ;;
        c)
            change_commit_date
            ;;
        q)
            echo "Exiting the program."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac

    echo
done
