#!/bin/bash

set -eo pipefail

[ -z "${GITHUB_TOKEN}" ] && { echo "Missing input.token!"; exit 2; }
[ -z "${OWNER}" ] && { echo "Missing input.owner!"; exit 2; }

# -----------

echo "Build release $VERSION"

# -----------

echo "Setting up gem version"
sed -e "s/1.0.0/${VERSION}/g" ./version.rb.template > ./lib/phrase/version.rb
rm ./version.rb.template

# -----------

echo "Building the gem"
gem build phrase.gemspec

# Create release
function create_release_data()
{
  cat <<EOF
{
  "tag_name": "${VERSION}",
  "name": "${VERSION}",
  "draft": true,
  "prerelease": false
}
EOF
}

echo "Create release $VERSION"
api_url="https://api.github.com/repos/phrase/phrase-ruby/releases?access_token=${GITHUB_TOKEN}"
response="$(curl --data "$(create_release_data)" ${api_url})"
release_id=$(echo $response | python -c "import sys, json; print(json.load(sys.stdin).get('id', ''))")

if [ -z "$release_id" ]
then
      echo "Failed to create GitHub release"
      echo $response
      exit 1
else
      echo "New release created created with id: ${release_id}"
fi

echo "Uploading ${file}"
file=phrase-${VERSION}.gem
asset="https://uploads.github.com/repos/phrase/phrase-ruby/releases/${release_id}/assets?name=$(basename "$file")&access_token=${GITHUB_TOKEN}"
curl --data-binary @"$file" -H "Content-Type: application/octet-stream" $asset > /dev/null
echo Hash: $(sha256sum $file)

# -----------

echo "Setting up access to RubyGems"
mkdir -p ~/.gem
touch ~/.gem/credentials
chmod 600 ~/.gem/credentials
echo ":rubygems_api_key: ${RUBYGEMS_TOKEN}" > ~/.gem/credentials

echo "Pushing the built gem to RubyGems"
gem push phrase-${VERSION}.gem

# -----------
# file name and specs must match repo name for Github Packages

echo "Building the phrase-ruby gem"
sed -e "s/\"phrase\"/\"phrase-ruby\"/g" ./phrase.gemspec > ./phrase-ruby.gemspec
gem build phrase-ruby.gemspec

echo "Setting up access to GitHub Package Registry"
mkdir -p ~/.gem
touch ~/.gem/credentials
chmod 600 ~/.gem/credentials
echo ":github: Bearer ${GITHUB_TOKEN}" > ~/.gem/credentials

echo "Pushing the built gem to GitHub Package Registry"
gem push --key github --host https://rubygems.pkg.github.com/${OWNER} phrase-ruby-${VERSION}.gem

echo "Publishing release"
curl \
  --silent \
  -X PATCH \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/phrase/phrase-ruby/releases/${release_id}" \
  -d '{"draft": false}' > /dev/null

echo "Release successful"
