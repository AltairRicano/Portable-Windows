Portable Windows Development Environment
A PowerShell script that automatically configures a temporary, portable development environment from a USB drive on any Windows machine.

The Problem
As a student and competitive programmer, I often need to switch between different computers. Setting up a development environment with all the necessary compilers and tools (Java JDK, C++, Python, .NET) on each machine is time-consuming.

The Solution
This script instantly configures a shell session by adding all the necessary tool paths from a pre-configured USB drive to the system's PATH variable. This allows me to start coding in seconds without any permanent installation on the host machine.

Features
Automatically detects the correct USB drive.

Configures paths for C++, Python, Java, .NET, and Git.

Sets required environment variables like JAVA_HOME.

Launches Visual Studio Code automatically.

Prerequisites
For this script to work, your USB drive must have the following folder structure:

$USB:\
├── dotnet-sdk\
├── Python\
├── msys64\
├── Java\
├── PortableGit\
└── MicrosoftVSCode\

How to use.

* Plug in the USB drive.
* Navigate to the root directory of the drive.
* Double-click the Visual Studio Code.bat file to launch the environment.
* This will automatically configure all the necessary paths and open a new instance of Visual Studio Code, ready to code!

The Launcher (.bat)
The Visual Studio Code.bat file is a simple launcher that executes the main PowerShell script while bypassing the execution policy for convenience. It contains the following command:
powershell -ExecutionPolicy Bypass -File "%~dp0setup_env.ps1"
