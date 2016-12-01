#!/usr/bin/env bash

STAGE=${STAGE:-dev}

echo "Testing POST request..."

curl -X POST -H 'Content-Type: application/json' \
  -d '{"query": "{ hello }"}' \
  "https://${API_ID}.execute-api.${AWS_REGION}.amazonaws.com/${STAGE}/graphql"

echo
echo
echo "Testing GET request..."

curl "https://${API_ID}.execute-api.${AWS_REGION}.amazonaws.com/${STAGE}/graphql?query=%7Bhello%7D"

echo
echo
echo "Done"
