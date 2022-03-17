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

curl \
  "${curl_args[@]}" \
  'https://github.com/open-policy-agent/gatekeeper/releases/download/v3.7.1/gator-v3.7.1-linux-amd64.tar.gz' \
  | \
    tar \
      --extract \
      --gzip \
      --directory "${tmpd}"
cp "${tmpd}"/gator 'bin'

curl \
  "${curl_args[@]}" \
  'https://download.docker.com/linux/static/stable/x86_64/docker-20.10.12.tgz' \
  | \
    tar \
      --extract \
      --gzip \
      --directory "${tmpd}"
cp "${tmpd}"/docker/docker 'bin'

curl \
  "${curl_args[@]}" \
  --output 'bin/kubectl' \
  'https://dl.k8s.io/release/v1.21.0/bin/linux/amd64/kubectl'

curl \
  "${curl_args[@]}" \
  --output 'bin/helmfile' \
  'https://github.com/roboll/helmfile/releases/download/v0.142.0/helmfile_linux_amd64'

curl \
  "${curl_args[@]}" \
  --output 'bin/jq' \
  'https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64'

curl \
  "${curl_args[@]}" \
  --output 'bin/yq' \
  'https://github.com/mikefarah/yq/releases/download/v4.16.1/yq_linux_amd64'

# devcontainer only
curl \
  "${curl_args[@]}" \
  --output 'bin/aws-iam-authenticator' \
  'https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator'

curl \
  "${curl_args[@]}" \
  'https://github.com/weaveworks/eksctl/releases/download/v0.82.0/eksctl_Linux_amd64.tar.gz' \
  | \
    tar \
      --extract \
      --gzip \
      --directory "${tmpd}"

mv "${tmpd}"/eksctl 'bin'

curl \
  "${curl_args[@]}" \
  'https://github.com/koalaman/shellcheck/releases/download/v0.8.0/shellcheck-v0.8.0.linux.x86_64.tar.xz' \
  | \
    tar \
      --extract \
      --xz \
      --directory "${tmpd}"

mv "${tmpd}"/shellcheck-v0.8.0/shellcheck 'bin'

curl \
  "${curl_args[@]}" \
  'https://get.helm.sh/helm-v3.7.2-linux-amd64.tar.gz' \
  | \
    tar \
      --gzip \
      --verbose \
      --extract \
      --directory "${tmpd}"

mv "${tmpd}"/linux-amd64/helm 'bin'

curl \
  "${curl_args[@]}" \
  --output "${tmpd}/awscliv2.zip" \
  "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.4.17.zip"

unzip -q "${tmpd}"/awscliv2.zip -d "${tmpd}"
"${tmpd}"/aws/install --install-dir '/home/vscode/aws-cli' --bin-dir '/home/vscode/bin'

chmod +x bin/* || true

rm -rf "${tmpd}"