#!/usr/bin/env bash
# setup.sh - Linux / macOS setup for understand-anything-csharp-fsharp
set -euo pipefail

echo "=== Understand-Anything C#/F# Support Setup ==="

echo "[1/5] Checking for 'just' command runner..."
if ! command -v just &> /dev/null; then
    echo "'just' not found. Installing..."
    # Try cargo first (common for Rust devs)
    if command -v cargo &> /dev/null; then
        cargo install just
    else
        # Fallback: official install script
        curl -sSf https://just.systems/install.sh | bash -s -- --to "$HOME/.local/bin"
        export PATH="$HOME/.local/bin:$PATH"
    fi
else
    echo "'just' is already installed: $(just --version)"
fi

echo "[2/5] Cloning original Understand-Anything repo (if needed)..."
if [ ! -d "original" ]; then
    git clone --depth 1 https://github.com/Egonex-AI/Understand-Anything.git original
else
    echo "original/ directory already exists. Skipping clone."
fi

echo "[3/5] Installing dependencies with pnpm..."
cd original
if ! command -v pnpm &> /dev/null; then
    echo "pnpm not found. Please install Node.js + pnpm first (recommended via corepack or Volta)."
    echo "Example: corepack enable && corepack prepare pnpm@latest --activate"
    exit 1
fi
pnpm install

echo "[4/5] Building core packages (best effort)..."
pnpm build 2>/dev/null || pnpm --filter "*core*" build 2>/dev/null || echo "Build step skipped or not required at this stage."

cd ..

echo "[5/5] Setup complete!"

echo ""
echo "Next steps:"
echo "  1. cd into this directory"
echo "  2. Run: just --list          # See available commands"
echo "  3. Explore proposed/ directory for C# and F# stubs"
echo "  4. Start editing queries and LanguageConfig in proposed/"
echo "  5. Use 'just clone-original' and 'just install-deps' as needed"
echo ""
echo "When ready to test changes, you will typically work inside original/ or create patches."
echo "See README.md for the full plan to upstream C#/F# support."

echo "Happy hacking! - Thomas Rizzo"