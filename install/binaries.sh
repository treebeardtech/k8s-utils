#!/usr/bin/env bash
# shellcheck disable=SC3030,3028,3054,3020,3010,3024,3040
set -eu -o pipefail
set -x

curl_args=(
  '--silent'
  '--fail'
  '--show-error'
  '--location'
)

mkdir 'bin'
tmpd="$(mktemp -d)"

# devcontainer only
curl \
  "${curl_args[@]}" \
  --output 'bin/aws-iam-authenticator' \
  'https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator'

chmod +x bin/* || true
rm -rf "${tmpd}"