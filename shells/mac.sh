#/bin/bash

CHROME_VERSION="131.0.6778.85"
BASE_URL="https://storage.googleapis.com/chrome-for-testing-public"

ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
    CHROME_ARCH="mac-arm64"
else
    CHROME_ARCH="mac-x64"
fi

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew installed"
else
    echo "Homebrew already installed"
fi

# Brew update
brew update

# Google Chrome
echo "Downloading Google Chrome"
curl -L -o chrome-$CHROME_ARCH.zip "$BASE_URL/$CHROME_VERSION/$CHROME_ARCH/chrome-$CHROME_ARCH.zip"
unzip -o chrome-$CHROME_ARCH.zip

mv chrome-$CHROME_ARCH/Google\ Chrome\ for\ Testing.app utils/
chmod +x utils/Google\ Chrome\ for\ Testing.app

rm -r chrome-$CHROME_ARCH
rm chrome-$CHROME_ARCH.zip

# Chromedriver
echo "Downloading Chromedriver"
curl -L -o chromedriver-$CHROME_ARCH.zip "$BASE_URL/$CHROME_VERSION/$CHROME_ARCH/chromedriver-$CHROME_ARCH.zip"
unzip -o chromedriver-$CHROME_ARCH.zip

mv chromedriver-$CHROME_ARCH/chromedriver utils/
chmod +x utils/chromedriver

rm -r chromedriver-$CHROME_ARCH
rm chromedriver-$CHROME_ARCH.zip

# Additional dependencies
brew install \
    glib \
    fontconfig

# Limpiar cache
brew cleanup