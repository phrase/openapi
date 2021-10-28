#!/bin/bash

set -eo pipefail

[ -z "${GITHUB_TOKEN}" ] && { echo "Missing input.token!"; exit 2; }

# -----------

echo "Build release $VERSION"

# -----------

echo "Setting up version"
sed -e "s/1.0.0/${VERSION}/g" ./setup.py > ./setup.py.tmp
rm ./setup.py
mv ./setup.py.tmp ./setup.py

# -----------

python3 -m pip install --user --upgrade setuptools wheel
python3 setup.py sdist bdist_wheel

# Create release
function create_release_data()
{
  cat <<EOF
{
  "tag_name": "${VERSION}",
  "name": "${VERSION}",
  "draft": false,
  "prerelease": false
}
EOF
}

echo "Create release $VERSION"
api_url="https://api.github.com/repos/phrase/phrase-python/releases"
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

DIST_DIR="./dist"
for file in "$DIST_DIR"/*; do
    echo "Uploading ${file}"
    asset="https://uploads.github.com/repos/phrase/phrase-python/releases/${release_id}/assets?name=$(basename "$file")"
    curl -sS --data-binary @"$file" -H "Authorization: token ${GITHUB_TOKEN}" -H "Content-Type: application/octet-stream" $asset > /dev/null
    echo Hash: $(sha256sum $file)
done

echo "Release successful"
