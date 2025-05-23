#!/data/data/com.termux/files/usr/bin/bash

# Check if .git exists
if [ ! -d .git ]; then
    echo "❌ This is not a Git repository."
    exit 1
fi

# Check if remote origin exists
if git remote get-url origin > /dev/null 2>&1; then
    current_remote=$(git remote get-url origin)
    echo "🌐 Current remote origin: $current_remote"
else
    echo "❗ No remote origin found."
    read -p "Enter SSH Git remote URL to add (eg... git@github.com:learncdwithme/coding.git) (or press Enter to cancel): " remote_url
    if [ -z "$remote_url" ]; then
        echo "❌ No remote URL provided. Exiting."
        exit 1
    fi
    git remote add origin "$remote_url"
    echo "✅ Remote 'origin' added: $remote_url"
fi

# Pull latest changes
echo "🔄 Pulling latest changes from origin..."
git pull origin
