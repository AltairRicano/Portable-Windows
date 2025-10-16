# Find all USB drives connected to the system.
$USB_DRIVES = Get-WMIObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq 2 }
$USB_PATH = $null

# Verify which USB drive is the correct development environment by looking for a key folder.
foreach ($Drive in $USB_DRIVES) {
    if (Test-Path "$($Drive.DeviceID)\dotnet-sdk") {
        $USB_PATH = $Drive.DeviceID
        break
    }
}

# If the development USB drive was found, proceed to set up the environment.
if ($USB_PATH) {
    Write-Host "Development USB drive found at $USB_PATH. Setting up environment..."

    # Define paths for all tools on the USB drive.
    $env:USB_PATH = $USB_PATH
    $DOTNET_PATH = Join-Path $USB_PATH "dotnet-sdk"
    $PYTHON_PATH = Join-Path $USB_PATH "Python"
    $MSYS_PATH = Join-Path $USB_PATH "msys64\mingw64\bin"
    $JAVA_PATH = Join-Path $USB_PATH "Java"
    $GIT_PATH = Join-Path $USB_PATH "PortableGit\bin"
    $CODE_PATH = Join-Path $USB_PATH "MicrosoftVSCode\Code.exe"

    # Set environment variables required by tools like Java.
    $env:JAVA_HOME = $JAVA_PATH
    $env:DOTNET_ROOT = $DOTNET_PATH

    # Add tool directories to the temporary PATH environment variable.
    # We check if each path exists before adding it.
    $newPath = ""
    if (Test-Path $DOTNET_PATH) { $newPath += "$DOTNET_PATH;" }
    if (Test-Path $PYTHON_PATH) { $newPath += "$PYTHON_PATH;" }
    if (Test-Path $MSYS_PATH) { $newPath += "$MSYS_PATH;" }
    if (Test-Path (Join-Path $JAVA_PATH "bin")) { $newPath += "$(Join-Path $JAVA_PATH 'bin');" }
    if (Test-Path $GIT_PATH) { $newPath += "$GIT_PATH;" }

    $env:Path = "$newPath$($env:Path)"

    Write-Host "Environment configured successfully. You can now use Dotnet, Python, C/C++, Java, and Git."

    # Launch Visual Studio Code if it exists.
    if (Test-Path $CODE_PATH) {
        Start-Process -FilePath $CODE_PATH
        Write-Host "Starting Visual Studio Code..."
    } else {
        Write-Host "Visual Studio Code not found on the USB drive."
    }
} else {
    Write-Host "Could not find the portable development USB drive."
}
