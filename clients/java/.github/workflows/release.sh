#!/bin/bash

set -eo pipefail

[ -z "${GITHUB_TOKEN}" ] && { echo "Missing input.token!"; exit 2; }

# -----------

echo "Build release $VERSION"

# -----------

gradle wrapper
./gradlew check assemble

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
api_url="https://api.github.com/repos/phrase/phrase-java/releases"
response="$(curl -H "Authorization: token ${GITHUB_TOKEN}" --data "$(create_release_data)" ${api_url})"
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
file=build/libs/phrase-java-${VERSION}.jar
asset="https://uploads.github.com/repos/phrase/phrase-java/releases/${release_id}/assets?name=$(basename "$file")"
curl --data-binary @"$file" -H "Authorization: token ${GITHUB_TOKEN}" -H "Content-Type: application/octet-stream" $asset > /dev/null
echo Hash: $(sha256sum $file)

echo "Pushing the built jar to GitHub Package Registry and Maven Central"
gradle publish closeAndReleaseSonatypeStagingRepository

echo "Release successful"
