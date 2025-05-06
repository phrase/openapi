set -eo pipefail

CERTIFICATE_BASE64=$1
P12_PASSWORD=$2
IDENTITY=$3
KEYCHAIN_PASSWORD=$4
DIST_DIR=$5

CERTIFICATE_PATH="./build_certificate.p12"
KEYCHAIN_PATH="./my-signing.keychain-db"

echo "🔐 Setting up certificate and keychain..."

# Decode the certificate
echo "$CERTIFICATE_BASE64" | base64 --decode -o "$CERTIFICATE_PATH"

# Create temporary keychain
security create-keychain -p "$KEYCHAIN_PASSWORD" "$KEYCHAIN_PATH"
security set-keychain-settings -lut 21600 "$KEYCHAIN_PATH"
security unlock-keychain -p "$KEYCHAIN_PASSWORD" "$KEYCHAIN_PATH"

# Import certificate into keychain
security import "$CERTIFICATE_PATH" -P "$P12_PASSWORD" -A -t cert -f pkcs12 -k "$KEYCHAIN_PATH"
security set-key-partition-list -S apple-tool:,apple: -k "$KEYCHAIN_PASSWORD" "$KEYCHAIN_PATH"
security list-keychain -d user -s "$KEYCHAIN_PATH"

# Find and sign all macOS binaries dynamically
echo "🔎 Searching for macOS binaries in $DIST_DIR..."

find "$DIST_DIR" -type f \( -name "phrase_macosx_*" ! -name "*.tar.gz" \) | while read -r binary; do
  echo "🔏 Signing $binary..."
  codesign --timestamp --options runtime --sign "$SIGNING_IDENTITY" "$binary"
  codesign --verify --verbose=2 "$binary"
done

echo "✅ All macOS binaries signed successfully."