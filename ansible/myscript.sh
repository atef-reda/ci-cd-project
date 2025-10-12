#!/bin/bash
# myscript.sh - Simple setup script for EC2 testing

echo "------------------------------------"
echo "✅ Running setup script on EC2"
echo "------------------------------------"

# Update system
sudo apt-get update -y

# Install basic packages
sudo apt-get install -y curl git

# Create a test file to confirm script ran
echo "Script executed successfully on $(hostname)" | sudo tee /home/ubuntu/script_result.txt

echo "✅ Done!"
