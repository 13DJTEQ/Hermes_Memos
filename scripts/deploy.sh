#!/usr/bin/env bash
# Reusable deploy entry point. Called by deploy-reusable.yml with:
#   $1 = environment (staging|prod)
#   $2 = release tag (vX.Y.Z)
# Replace the body with your real deploy. For a Hermes plugin this might push
# the package to a registry, rsync to a host, or publish a release artifact.
set -euo pipefail

ENV="${1:?usage: deploy.sh <staging|prod> <tag>}"
TAG="${2:?usage: deploy.sh <staging|prod> <tag>}"
DEPLOY_TOKEN="${DEPLOY_TOKEN:-}"

echo "Deploying ${TAG} to ${ENV}"

case "$ENV" in
  staging)
    echo "STAGING DEPLOY PLACEHOLDER for ${TAG}"
    ;;
  prod)
    echo "PROD DEPLOY PLACEHOLDER for ${TAG}"
    ;;
  *)
    echo "Unknown environment: $ENV" >&2
    exit 1
    ;;
esac

echo "Deploy to ${ENV} complete."
