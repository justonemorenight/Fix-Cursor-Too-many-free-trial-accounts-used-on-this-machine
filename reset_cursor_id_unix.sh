#!/bin/bash

# ---------- File Path Configuration ----------
if [[ "$OSTYPE" == darwin* ]]; then
    storage_file="$HOME/Library/Application Support/Cursor/User/globalStorage/storage.json"
else
    storage_file="$HOME/.config/Cursor/User/globalStorage/storage.json"
fi

# ---------- Check File Existence ----------
if [ ! -f "$storage_file" ]; then
    echo "Error: storage.json not found at $storage_file"
    exit 1
fi

# ---------- UUID Generation Function ----------
generate_uuid() {
    if command -v uuidgen >/dev/null 2>&1; then
        uuidgen
    else
        # Fallback for systems without uuidgen
        od -x /dev/urandom | head -1 | awk -v OFS='-' '{
            print substr($2$3,1,8),
            substr($2$3,9,4),
            substr($4,1,4),
            substr($4,5,4),
            substr($5$6$7,1,12)
        }' | tr '[:upper:]' '[:lower:]'
    fi
}

# ---------- 64-char Hex Generator ----------
generate_hex() {
    od -An -tx1 -N32 /dev/urandom | tr -d ' \n'
}

# ---------- Main Logic ----------
try_chmod() {
    if ! chmod 666 "$storage_file" 2>/dev/null; then
        echo "Error: Failed to change file permissions. Run script with sudo."
        exit 1
    fi
}

# Generate new values
uuid=$(generate_uuid)
hex1=$(generate_hex)
hex2=$(generate_hex)

# Modify file permissions and write
try_chmod

cat > "$storage_file" << EOF
{
  "telemetry.macMachineId": "$hex1",
  "telemetry.machineId": "$hex2",
  "telemetry.devDeviceId": "$uuid"
}
EOF

# Set read-only permissions
chmod 444 "$storage_file"

# ---------- Display Results ----------
cat << EOF

✅ Changes applied successfully!
──────────────────────────────
📁 File path: $storage_file
🔑 macMachineId: $hex1
🔑 machineId: $hex2
🔑 devDeviceId: $uuid
──────────────────────────────
💡 Note: Values will change each time you run this script
EOF
