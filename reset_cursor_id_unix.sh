#!/bin/bash

# Set file path
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    storage_file="$HOME/Library/Application Support/Cursor/User/globalStorage/storage.json"
else
    storage_file="$HOME/.config/Cursor/User/globalStorage/storage.json"
fi

# Check if file exists
if [ ! -f "$storage_file" ]; then
    echo "Error: storage.json not found at $storage_file"
    exit 1
fi

# Function to generate UUID without uuidgen
generate_uuid() {
    if command -v uuidgen >/dev/null 2>&1; then
        uuidgen
    else
        # Fallback method using /dev/urandom
        od -x /dev/urandom | head -1 | awk '{OFS="-"; print $2$3,$4,$5,$6,$7$8$9}' | cut -c1-36
    fi
}

# Generate random values
uuid=$(generate_uuid)
hex1=$(cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 64 | head -n 1)
hex2=$(cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 64 | head -n 1)

# Set read-write permissions (666) for modification
chmod 666 "$storage_file"

# Create new JSON content
cat > "$storage_file" << EOF
{
  "telemetry.macMachineId": "$hex1",
  "telemetry.machineId": "$hex2",
  "telemetry.devDeviceId": "$uuid"
}
EOF

# Set read-only permissions (444)
chmod 444 "$storage_file"

echo "Done! File has been updated with new random values."
echo
echo "New values:"
echo "macMachineId: $hex1"
echo "machineId: $hex2"
echo "devDeviceId: $uuid"
echo
 
