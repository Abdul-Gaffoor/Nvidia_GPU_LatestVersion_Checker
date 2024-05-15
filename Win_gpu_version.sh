#!/bin/bash

# Define variables
BUCKET="nvidia-gaming"
KEY_PREFIX="windows/latest"
REGION="us-east-1"

# Get the list of objects in the bucket with the specified prefix
OBJECTS=$(aws s3api list-objects --bucket "$BUCKET" --prefix "$KEY_PREFIX" --region "$REGION" --query 'Contents[?Size > `0`].Key' --output json)

# Parse the JSON to extract the keys
KEYS=$(echo "$OBJECTS" | jq -r '.[]')

# Print the header for the output
echo "========================================="
echo "Latest Windows Drivers from AWS:"
echo "========================================="
echo ""

# Print each key
for KEY in $KEYS; do
    echo "File Path: $KEY"
done

# Extract the version from the filename and print the formatted output
for KEY in $KEYS; do
    if [[ "$KEY" =~ windows/latest/([0-9]+\.[0-9]+_Cloud_Gaming_win10_win11_server2022_dch_64bit_international) ]]; then
        LATEST_GPU_WIN_VERSION="${BASH_REMATCH[1]}"
        echo ""
        echo "========================================="
        echo "Extracted GPU Version:"
        echo "========================================="
        echo "Latest_GPU_Win_Version= $LATEST_GPU_WIN_VERSION"
    fi
done
