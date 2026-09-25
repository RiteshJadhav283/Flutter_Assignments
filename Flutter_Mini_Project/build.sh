#!/bin/bash
set -e

# Check if flutter is available, otherwise download it (e.g. for Vercel build environment)
if ! command -v flutter &> /dev/null; then
  echo "Flutter command not found. Setting up Flutter SDK..."
  if [ ! -d "$HOME/flutter" ]; then
    echo "Cloning Flutter SDK (stable branch)..."
    git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$HOME/flutter"
  fi
  export PATH="$PATH:$HOME/flutter/bin"
fi

echo "=== Flutter Version ==="
flutter --version

echo "=== Getting dependencies ==="
flutter pub get

echo "=== Building Flutter Web Release ==="
flutter build web --release

echo "=== Build Succeeded! Output in build/web ==="
