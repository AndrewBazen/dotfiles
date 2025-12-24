@echo off
echo Running Windows CMD setup...
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -File "%~dp0windows.ps1"