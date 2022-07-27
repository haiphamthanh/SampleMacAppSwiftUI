#!/bin/bash

# Ask the user for their email
while : ; do
    echo "To generate SSH file, please input your email:"
    read email
    echo "Nice ${email}"
    
    echo "Are you sure your email? (y/n)"
    read isSure
    if [[ $isSure == y ]] 
    then 
        break
    fi
done

echo "Generating public/private algorithm key pair for: ${email}"
ssh-keygen -t ed25519 -C "${email}"
eval "$(ssh-agent -s)"
open ~/.ssh/