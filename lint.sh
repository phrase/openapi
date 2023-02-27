#!/bin/bash

output=$(npx openapi-generator-cli validate -i tmp/compiled.yaml | grep -v "inheritance without use of 'discriminator.propertyName'" | grep -v "No validation issues detected.")
if echo "$output" | grep -q -E "WARN|ERROR"; then
    echo "$output"
    echo "Validation errors"
    exit 1
else
    echo "No validation errors"
fi
