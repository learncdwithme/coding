#!/data/data/com.termux/files/usr/bin/bash

# Check if .git exists; if not, initialize
if [ ! -d .git ]; then
    echo "🛠 Initializing new Git repository..."
    git init
fi

# Add all files
git add .

# Commit with message
read -p "Enter commit message: " commit_msg
commit_msg=${commit_msg:-"Update"}
git commit -m "$commit_msg"

# Ask for branch to push
read -p "Enter branch name to push [default: main]: " branch
branch=${branch:-main}
git branch -M "$branch"
# Check if remote 'origin' exists
if git remote get-url origin > /dev/null 2>&1; then
    echo "🌐 Current remote origin: $(git remote get-url origin)"
else
    read -p "No remote found. Enter SSH Git remote URL: " remote_url
    echo "Remote eg. git@github.com:learncdwithme/coding.git"
    git remote add origin "$remote_url"
    echo "✅ Remote 'origin' added."
fi

# Push to GitHub
echo "🚀 Pushing to origin/$branch..."
git push -u origin "$branch"
