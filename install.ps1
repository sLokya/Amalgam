param(
    [ValidateSet("codex", "all")]
    [string]$Target = "codex",
    [string]$CodexHome,
    [switch]$SkipCatalog,
    [switch]$WhatIf
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$Root = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent $MyInvocation.MyCommand.Path }
$SkillName = Split-Path -Leaf $Root

function Write-Step {
    param([string]$Message)
    Write-Host "[agent-context-router] $Message"
}

function Get-CodexHome {
    if (-not [string]::IsNullOrWhiteSpace($CodexHome)) {
        return $CodexHome
    }

    if (-not [string]::IsNullOrWhiteSpace($env:CODEX_HOME)) {
        return $env:CODEX_HOME
    }

    $homeDir = [Environment]::GetFolderPath("UserProfile")
    if ([string]::IsNullOrWhiteSpace($homeDir)) {
        $homeDir = $HOME
    }

    if ([string]::IsNullOrWhiteSpace($homeDir)) {
        throw "Cannot determine user home. Pass -CodexHome explicitly."
    }

    return (Join-Path $homeDir ".codex")
}

function Invoke-Git {
    param([Parameter(Mandatory=$true)][string[]]$Arguments)

    & git @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "git $($Arguments -join ' ') failed with exit code $LASTEXITCODE"
    }
}

function Get-GitOutput {
    param([Parameter(Mandatory=$true)][string[]]$Arguments)

    $output = & git @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "git $($Arguments -join ' ') failed with exit code $LASTEXITCODE"
    }

    return (($output | Out-String).Trim())
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
    $ResolvedCodexHome = Get-CodexHome
    $CodexSkillsDir = Join-Path $ResolvedCodexHome "skills"
    $CodexDest = Join-Path $CodexSkillsDir $SkillName

    Write-Step "Syncing Codex skills repo: $CodexDest"

    $RemoteUrl = Get-GitOutput @("-C", $Root, "config", "--get", "remote.origin.url")
    if ([string]::IsNullOrWhiteSpace($RemoteUrl)) {
        throw "Cannot determine source git remote. Configure remote.origin.url before installing."
    }

    if ($WhatIf) {
        Write-Host "Would create: $CodexSkillsDir"
        if (Test-Path -LiteralPath $CodexDest) {
            Write-Host "Would run: git -C <codex-skill-dir> pull --ff-only"
        }
        else {
            Write-Host "Would run: git clone <source-remote> <codex-skill-dir>"
        }
        return
    }

    New-Item -ItemType Directory -Force -Path $CodexSkillsDir | Out-Null

    if (Test-Path -LiteralPath $CodexDest) {
        $GitDir = Join-Path $CodexDest ".git"
        if (-not (Test-Path -LiteralPath $GitDir)) {
            throw "Codex target already exists but is not a git repository: $CodexDest. Move it aside or clone the skill repository there manually."
        }

        $TargetStatus = Get-GitOutput @("-C", $CodexDest, "status", "--porcelain")
        if (-not [string]::IsNullOrWhiteSpace($TargetStatus)) {
            throw "Codex target has local changes. Commit, stash, or clean it before git pull: $CodexDest"
        }

        Write-Step "Pulling latest committed skill source"
        Invoke-Git @("-C", $CodexDest, "pull", "--ff-only")
    }
    else {
        Write-Step "Cloning skill source from git remote"
        Invoke-Git @("clone", $RemoteUrl, $CodexDest)
    }

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
