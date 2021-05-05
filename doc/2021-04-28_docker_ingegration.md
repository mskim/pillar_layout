# Docker Integertion

make NewsGo Page as portable.
that is! It can be saved, moved around, download, edit, upload back
generate PDF in and local machine.

## Problem
PDF generation is done on NewsGO server only.
Wish to do it offline as well. 
But installing NewsGo PDF generation on Windows machine is tricky.

## Solution
Install Docker, VSCode with remote-docker plugin, PDFViewer plug-in.
Docker installs OS Ruby ruby rlayout, hexapdf gem and executes rake tasks which generate

Add Dockerfile docker-compose  we archive Page, 
Download Page Archive folder, to Docker installed machine.
Edit story files with VSCode, lanunch Docker from VScode
run rake in VSCode terminal.

generate page pdf
preview locally and upload the Page Back to load fixed page back to server
