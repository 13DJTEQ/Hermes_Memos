#!/usr/bin/env bash
# Deploy entry point for Hermes_Memos.
# On a version tag, packages the plugin and publishes it as a GitHub Release
# asset in THIS repo (GitHub-native deploy, authorized by DEPLOY_TOKEN).
#   $1 = environment (staging|prod)
#   $2 = release tag (vX.Y.Z)
set -euo pipefail

ENV="${1:?usage: deploy.sh <staging|prod> <tag>}"
TAG="${2:?usage: deploy.sh <staging|prod> <tag>}"
TOKEN="${DEPLOY_TOKEN:-}"
REPO="${GITHUB_REPOSITORY:-13DJTEQ/Hermes_Memos}"

if [ -z "$TOKEN" ]; then
  echo "DEPLOY_TOKEN not set; aborting." >&2
  exit 1
fi

echo "Deploying ${TAG} to ${ENV}"

# Only publish a Release on prod; staging just validates the package builds.
ASSET_NAME="hermes-memos-${TAG}.tar.gz"
tar -czf "/tmp/${ASSET_NAME}" --exclude='.git' --exclude='__pycache__' .

if [ "$ENV" = "prod" ]; then
  echo "Creating GitHub release ${TAG} and uploading ${ASSET_NAME}"
  gh release create "${TAG}" "/tmp/${ASSET_NAME}" \
    --repo "${REPO}" \
    --title "${TAG}" \
    --notes "Automated release ${TAG} (${ENV})" \
    --token "${TOKEN}"
else
  echo "STAGING: package built at /tmp/${ASSET_NAME} (no release published)"
fi

echo "Deploy to ${ENV} complete."
