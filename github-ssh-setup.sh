#!/data/data/com.termux/files/usr/bin/bash

# Install git if not present
pkg update -y && pkg install -y git openssh

# Ask for user name and email
read -p "Enter your Git username: " git_username
read -p "Enter your Git email: " git_email

# Set Git config
git config --global user.name "$git_username"
git config --global user.email "$git_email"

# Generate SSH key
echo "Generating new SSH key..."
ssh-keygen -t ed25519 -C "$git_email" -f ~/.ssh/id_ed25519 -N ""

# Start SSH agent and add key
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Display the public key
echo
echo "🔑 Your public SSH key is:"
echo "--------------------------------------------------"
cat ~/.ssh/id_ed25519.pub
echo "--------------------------------------------------"
echo

# Prompt to add key to GitHub
echo "👉 Copy the above SSH key and add it to your GitHub account:"
echo "   https://github.com/settings/keys"
read -p "Press ENTER once you've added the key to GitHub..."

# Test SSH connection
echo
echo "Testing SSH connection to GitHub..."
ssh -T git@github.com

echo
echo "✅ SSH setup for GitHub complete!"
