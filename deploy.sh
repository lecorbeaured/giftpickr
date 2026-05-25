#!/bin/bash
# ─────────────────────────────────────────────
# giftpickr.live — Deploy Setup Script
# Run from: /Users/mollah/Desktop/WEBSITES/giftpickr
# ─────────────────────────────────────────────

set -e

REPO_NAME="giftpickr"
GITHUB_USER="lecorbeaured"
DOMAIN="giftpickr.live"

echo ""
echo "🎁 giftpickr.live Deploy Setup"
echo "────────────────────────────────"

# Confirm we're in the right place
if [ ! -f "vercel.json" ]; then
  echo "✗ Error: run this script from inside the giftpickr folder"
  echo "  cd /Users/mollah/Desktop/WEBSITES/giftpickr && bash deploy.sh"
  exit 1
fi

# Check gh is installed
if ! command -v gh &> /dev/null; then
  echo "✗ GitHub CLI not found. Install it:"
  echo "  brew install gh && gh auth login"
  exit 1
fi

# Check git is configured
if ! git config user.email &> /dev/null; then
  echo "✗ Git not configured. Run:"
  echo "  git config --global user.email 'you@email.com'"
  echo "  git config --global user.name 'Your Name'"
  exit 1
fi

echo "→ Initialising git repo..."
git init
git add .
git commit -m "Initial deploy — 29 gift guide pages · giftpickr.live"

echo "→ Creating GitHub repo ${GITHUB_USER}/${REPO_NAME}..."
gh repo create "${GITHUB_USER}/${REPO_NAME}" --public --source=. --remote=origin --push

echo ""
echo "✅ Repo live: https://github.com/${GITHUB_USER}/${REPO_NAME}"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " Next: Vercel setup (2 min)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " 1. vercel.com → Add New Project"
echo " 2. Import: github.com/${GITHUB_USER}/${REPO_NAME}"
echo " 3. Root Directory → set to:  public"
echo " 4. Click Deploy"
echo " 5. Project → Domains → Add: ${DOMAIN}"
echo " 6. Add DNS records at your registrar (Vercel shows exact values)"
echo " 7. Submit sitemap to Google Search Console:"
echo "    https://${DOMAIN}/sitemap.xml"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
