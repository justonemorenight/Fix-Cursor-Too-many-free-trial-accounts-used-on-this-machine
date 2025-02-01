# Reset Cursor ID Script

Scripts to reset identification values in Cursor Editor's storage.json file for Windows, Linux, and macOS.

## Purpose

This script is designed to help resolve the error message:
> "Too many free trial accounts used on this machine. Please upgrade to pro. We have this limit in place to prevent abuse."

This tool is intended for legitimate users who encounter identification issues with their free trial, not for bypassing software licensing or creating unlimited trial accounts.

## Disclaimer

- This script is provided for educational and troubleshooting purposes only.
- It is not intended to bypass software licensing or create unlimited trial accounts.
- Users should comply with Cursor Editor's terms of service and licensing agreements.
- The script authors are not responsible for any misuse or potential consequences.
- If you frequently encounter trial limitations, please consider purchasing a license to support the software developers.

## Description

These scripts perform the following operations:
- Generate new random IDs for `macMachineId`, `machineId`, and `devDeviceId`
- Update the storage.json file with new values
- Set appropriate file permissions

## Requirements

### Windows
- Windows Operating System
- PowerShell
- Administrator privileges

### Linux/macOS
- Bash shell
- `uuidgen` utility
- Execute permissions

## Storage File Location

The storage.json file is located at:

```plaintext
Windows: %APPDATA%\Cursor\User\globalStorage\storage.json
Linux/macOS: ~/.config/Cursor/User/globalStorage/storage.json
```

## Usage

### Windows
1. **Important:** Ensure that Cursor Editor is **open** before running the script.
2. Run `reset_cursor_id_windows.bat`.
3. If prompted for admin rights, click "Yes".

### Linux/macOS
1. **Important:** Ensure that Cursor Editor is **open** before running the script.
2. Make the script executable: `chmod +x reset_cursor_id_unix.sh`.
3. Run the script: `./reset_cursor_id_unix.sh`.

The scripts will automatically:
- Generate new random IDs.
- Update the storage.json file.
- Display the newly generated IDs.

## Features

- Platform-specific implementations (Windows batch & Unix shell script)
- Random UUID generation:
  - Windows: Using PowerShell's Guid
  - Linux/macOS: Using uuidgen or fallback to /dev/urandom
- Random hex string generation for machine IDs
- File permission handling:
  - Windows: Using attrib
  - Linux/macOS: Using chmod
- Automatic error handling and dependency checking

## Important Notes

- **For version 0.45:** Make sure Cursor Editor is open when running the script.
- The storage.json file will be set to read-only after update.
- A backup is created automatically before any modifications.

## Example Output

```plaintext
Done! File has been updated with new random values.

New values:
macMachineId: [64-character hex string]
machineId: [64-character hex string]
devDeviceId: [UUID format]
```

## Troubleshooting

If you encounter issues:
1. Ensure Cursor Editor is **open**.
2. Run with appropriate permissions:
   - Windows: Run as administrator.
   - Linux/macOS: Ensure execute permissions (`chmod +x`).
3. Check if the storage.json file exists.
4. Verify write permissions in the directory.
