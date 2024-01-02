#!/bin/bash
sudo apt-get update
sudo apt-get install -y apt-transport-https aspnetcore-runtime-7.0
mkdir nop && cd nop
sudo wget https://github.com/nopSolutions/nopCommerce/releases/download/release-4.60.5/nopCommerce_4.60.5_NoSource_linux_x64.zip
sudo apt-get install unzip
sudo unzip nopCommerce_4.60.5_NoSource_linux_x64.zip
dotnet Nop.Web.dll --urls "http://0.0.0.0:5000"