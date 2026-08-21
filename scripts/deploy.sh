#!/usr/bin/env bash
# Reusable deploy entry point. Called by deploy-reusable.yml with:
#   $1 = environment (staging|prod)
#   $2 = release tag (vX.Y.Z)
# Replace the body with your real deploy (kubectl, ssh, fastlane, etc.).
# Keep it environment-driven via $1 so the same script serves every stage.
set -euo pipefail

ENV="${1:?usage: deploy.sh <staging|prod> <tag>}"
TAG="${2:?usage: deploy.sh <staging|prod> <tag>}"
DEPLOY_TOKEN="${DEPLOY_TOKEN:-}"

echo "Deploying ${TAG} to ${ENV}"

case "$ENV" in
  staging)
    # Example: push image, apply manifest, wait for rollout.
    # docker push "registry.example.com/app:${TAG}"
    # kubectl set image deploy/app app="registry.example.com/app:${TAG}" --namespace=staging
    echo "STAGING DEPLOY PLACEHOLDER for ${TAG}"
    ;;
  prod)
    # Gate prod behind an explicit approval (GitHub environment) + health check.
    echo "PROD DEPLOY PLACEHOLDER for ${TAG}"
    ;;
  *)
    echo "Unknown environment: $ENV" >&2
    exit 1
    ;;
esac

echo "Deploy to ${ENV} complete."
