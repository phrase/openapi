#!/bin/bash

set -eo pipefail

brew_dir=$(mktemp -d -t ci-XXXXXXXXXX)
git clone --depth 1 https://$API_TOKEN_GITHUB@github.com/phrase/homebrew-brewed.git $brew_dir &> /dev/null

# Upload artifacts
DIST_DIR="./dist"
FILES_FOR_BREW=("phrase_linux_386.tar.gz" "phrase_linux_amd64.tar.gz" "phrase_macosx_amd64.tar.gz")

# Change the sha256 in Formula/phrase.rb
for file in ${FILES_FOR_BREW[@]}; do
  sha256=$(sha256sum "$DIST_DIR/$file" | awk '{ print $1 }')
  sed -i '' "s/sha256 \".*\" # $file/sha256 \"$sha256\" # $file/g" "$brew_dir/Formula/phrase.rb"
done

# Change the version in Formula/phrase.rb
sed -i '' "s/version \".*\"/version \"$VERSION\"/g" "$brew_dir/Formula/phrase.rb"

cd $brew_dir
git config --global user.email "support@phrase.com"
git config --global user.name "Phrase"
git add Formula/phrase.rb
git commit -m "Release version $VERSION"
git push origin master

echo $brew_dir
echo "Brew release successful"
