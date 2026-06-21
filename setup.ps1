# setup.ps1 - Windows setup for understand-anything-csharp-fsharp
# Run in PowerShell (preferably PowerShell 7+)

Write-Host "=== Understand-Anything C#/F# Support Setup (Windows) ===" -ForegroundColor Cyan

# Function to check if a command exists
function Test-Command($cmd) {
    $null -ne (Get-Command $cmd -ErrorAction SilentlyContinue)
}

Write-Host "[1/5] Checking for 'just' command runner..." -ForegroundColor Yellow
if (-not (Test-Command just)) {
    Write-Host "'just' not found. Attempting to install..." -ForegroundColor Yellow

    # Preferred: winget (Windows 10/11)
    if (Test-Command winget) {
        Write-Host "Installing just via winget..."
        winget install --id Casey.Just -e --accept-package-agreements --accept-source-agreements
    }
    elseif (Test-Command scoop) {
        Write-Host "Installing just via scoop..."
        scoop install just
    }
    else {
        Write-Host "Please install 'just' manually:" -ForegroundColor Red
        Write-Host "  - winget: winget install Casey.Just"
        Write-Host "  - scoop: scoop install just"
        Write-Host "  - Or download from https://github.com/casey/just/releases"
        Write-Host "After installing, re-run this script."
        exit 1
    }
} else {
    Write-Host "'just' is already installed." -ForegroundColor Green
}

Write-Host "[2/5] Cloning original Understand-Anything repo (if needed)..." -ForegroundColor Yellow
if (-not (Test-Path "original")) {
    git clone --depth 1 https://github.com/Egonex-AI/Understand-Anything.git original
} else {
    Write-Host "original/ directory already exists. Skipping clone."
}

Write-Host "[3/5] Installing dependencies with pnpm..." -ForegroundColor Yellow
Set-Location original

if (-not (Test-Command pnpm)) {
    Write-Host "pnpm not found!" -ForegroundColor Red
    Write-Host "Please install Node.js + pnpm first." -ForegroundColor Red
    Write-Host "Recommended: Use 'corepack enable' after installing Node.js, or install via Volta / fnm."
    Write-Host "Example: corepack enable && corepack prepare pnpm@latest --activate"
    exit 1
}

pnpm install

Write-Host "[4/5] Building core packages (best effort)..." -ForegroundColor Yellow
try {
    pnpm build | Out-Null
} catch {
    try {
        pnpm --filter "*core*" build | Out-Null
    } catch {
        Write-Host "Build step skipped or not strictly required at this stage."
    }
}

Set-Location ..

Write-Host "[5/5] Setup complete!" -ForegroundColor Green

Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Open this folder in your terminal / VS Code"
Write-Host "  2. Run: just --list                 # See available commands"
Write-Host "  3. Explore the proposed/ directory for C# and F# starter files"
Write-Host "  4. Edit queries and LanguageConfig stubs"
Write-Host "  5. Use 'just clone-original' and 'just install-deps' when needed"
Write-Host ""
Write-Host "When ready to test, work inside the 'original/' clone or prepare patches for upstreaming." -ForegroundColor Cyan
Write-Host "See README.md for the detailed plan."
Write-Host ""
Write-Host "Happy hacking! - Thomas Rizzo" -ForegroundColor Green