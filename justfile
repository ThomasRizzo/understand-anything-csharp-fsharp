# justfile - Common tasks for understand-anything-csharp-fsharp

# Show available commands
default:
    @just --list

# One-time setup (run setup.sh or setup.ps1 instead for full automation)
setup:
    @echo "Use ./setup.sh (Linux/macOS) or .\\setup.ps1 (Windows) for full setup"

# Clone the original Understand-Anything repository
clone-original:
    @if [ -d "original" ]; then \
        echo "original/ already exists. Skipping clone."; \
    else \
        git clone --depth 1 https://github.com/Egonex-AI/Understand-Anything.git original; \
    fi

# Install dependencies in the original repo (pnpm)
install-deps:
    cd original && pnpm install

# Build core packages (adjust command if the original uses different scripts)
build:
    cd original && pnpm build || pnpm --filter understand-anything-plugin build || echo "Check package.json scripts"

# Clean build artifacts
clean:
    rm -rf original/node_modules original/.pnpm-store 2>/dev/null || true
    echo "Cleaned common artifacts"

# Show status of original clone
status:
    @echo "=== Original repo status ==="
    @cd original && git status --short || echo "No original/ directory yet"

# Example: Open the proposed C# queries for editing
edit-csharp:
    $EDITOR proposed/csharp/queries.scm || code proposed/csharp/queries.scm

edit-fsharp:
    $EDITOR proposed/fsharp/queries.scm || code proposed/fsharp/queries.scm

# Future: Apply proposed changes as a patch (to be implemented)
# apply-proposed:
#     patch -p1 -d original < proposed/csharp-fsharp.patch || echo "Patch not ready yet"

# Run tests in original (placeholder)
test:
    cd original && pnpm test || echo "Tests not fully configured yet"

# Update this repo from upstream changes in original (advanced)
update-from-original:
    cd original && git pull