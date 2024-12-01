#!/bin/bash

CHROME_VERSION="131.0.6778.85"
BASE_URL="https://storage.googleapis.com/chrome-for-testing-public"
CHROME_ARCH="linux64"

# Update system and install basic dependencies
sudo apt-get update
sudo apt-get install -y wget gnupg2 unzip

# Google Chrome
echo "Downloading Google Chrome..."
wget -N "$BASE_URL/$CHROME_VERSION/$CHROME_ARCH/chrome-$CHROME_ARCH.zip"
unzip -o chrome-$CHROME_ARCH.zip

mv chrome-$CHROME_ARCH/Google\ Chrome\ for\ Testing.app utils/
chmod +x utils/Google\ Chrome\ for\ Testing.app

rm -r chrome-$CHROME_ARCH
rm chrome-$CHROME_ARCH.zip

# Chromedriver
echo "Installing Chromedriver..."
wget -N "$BASE_URL/$CHROME_VERSION/$CHROME_ARCH/chromedriver-$CHROME_ARCH.zip"
unzip -o chromedriver-$CHROME_ARCH.zip

mv chromedriver-$CHROME_ARCH/chromedriver utils/
chmod +x utils/chromedriver

rm -r chromedriver-$CHROME_ARCH
rm chromedriver-$CHROME_ARCH.zip

# Additional dependencies 
sudo apt-get update
sudo apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libfontconfig1


# Clean cache and temp files
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*