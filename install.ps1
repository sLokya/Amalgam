param(
    [ValidateSet("codex", "all")]
    [string]$Target = "codex",
    [switch]$SkipCatalog,
    [switch]$WhatIf
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillName = Split-Path -Leaf $Root
$CodexSkillsDir = Join-Path $env:USERPROFILE ".codex\skills"
$CodexDest = Join-Path $CodexSkillsDir $SkillName

function Write-Step {
    param([string]$Message)
    Write-Host "[agent-context-router] $Message"
}

function Rebuild-Catalog {
    if ($SkipCatalog) {
        Write-Step "Skipping catalog rebuild"
        return
    }

    $script = Join-Path $Root "scripts\build_catalog.py"
    if (-not (Test-Path -LiteralPath $script)) {
        throw "Missing catalog builder: $script"
    }

    Write-Step "Rebuilding catalog"
    if (-not $WhatIf) {
        & python $script
    }
}

function Install-Codex {
    Write-Step "Installing to Codex skills: $CodexDest"

    if ($WhatIf) {
        Write-Host "Would create: $CodexSkillsDir"
        Write-Host "Would replace: $CodexDest"
        return
    }

    New-Item -ItemType Directory -Force -Path $CodexSkillsDir | Out-Null

    if (Test-Path -LiteralPath $CodexDest) {
        Remove-Item -LiteralPath $CodexDest -Recurse -Force
    }

    Copy-Item -LiteralPath $Root -Destination $CodexDest -Recurse -Force
    Write-Step "Done. Restart Codex App or start a new conversation to refresh skills."
}

function Install-All {
    Install-Codex

    Write-Step "Other app installers are placeholders for now."
    Write-Step "Add future targets here, e.g. Claude Code, Cursor, OpenCode, Qwen, or Gemini."
}

Rebuild-Catalog

switch ($Target) {
    "codex" { Install-Codex }
    "all" { Install-All }
}
