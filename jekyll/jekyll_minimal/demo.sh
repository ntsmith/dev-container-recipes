#!/bin/bash
# Jekyll Minimal Demo
# Builds the site and serves it locally

set -e

echo "=== Jekyll Minimal Demo ==="
echo ""

# Install dependencies if needed
if [ ! -d "vendor/bundle" ]; then
    echo "Installing dependencies..."
    bundle install
fi

echo "Building site..."
bundle exec jekyll build

echo ""
echo "Site built successfully!"
echo "Output in _site/"
echo ""
echo "Files generated:"
ls -la _site/

echo ""
echo "To serve the site, run:"
echo "  bundle exec jekyll serve --host 0.0.0.0"
echo ""
echo "Then open http://localhost:4000 in your browser"
