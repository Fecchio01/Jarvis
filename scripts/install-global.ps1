$ErrorActionPreference = "Stop"

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$AgentsHome = Join-Path $CodexHome "agents"
$SkillsHome = Join-Path $HOME ".agents/skills"
$GlobalAgents = Join-Path $CodexHome "AGENTS.md"
$UserPreferences = Join-Path $CodexHome "USER-PREFERENCES.md"
$BeginMarker = "<!-- BEGIN JARVIS MANAGED GLOBAL INSTRUCTIONS -->"
$EndMarker = "<!-- END JARVIS MANAGED GLOBAL INSTRUCTIONS -->"
$NewLine = [Environment]::NewLine

New-Item -ItemType Directory -Force -Path $AgentsHome, $SkillsHome | Out-Null
$Current = if (Test-Path $GlobalAgents) { Get-Content -Raw -Encoding UTF8 $GlobalAgents } else { "" }
$Managed = (Get-Content -Raw -Encoding UTF8 (Join-Path $RepoRoot "AGENTS.md")).Trim()
$Block = $BeginMarker + $NewLine + $Managed + $NewLine + $EndMarker
$Pattern = "(?s)" + [regex]::Escape($BeginMarker) + ".*?" + [regex]::Escape($EndMarker)

if ([regex]::IsMatch($Current, $Pattern)) {
    $Updated = [regex]::Replace($Current, $Pattern, [System.Text.RegularExpressions.MatchEvaluator]{ param($m) $Block })
} elseif ([string]::IsNullOrWhiteSpace($Current)) {
    $Updated = $Block + $NewLine
} else {
    $Updated = $Current.TrimEnd() + $NewLine + $NewLine + $Block + $NewLine
}
Set-Content -Path $GlobalAgents -Value $Updated -Encoding UTF8

Copy-Item -Path (Join-Path $RepoRoot ".codex/agents/*") -Destination $AgentsHome -Recurse -Force
Copy-Item -Path (Join-Path $RepoRoot ".codex/USER-PREFERENCES.md") -Destination $UserPreferences -Force
Copy-Item -Path (Join-Path $RepoRoot ".agents/skills/*") -Destination $SkillsHome -Recurse -Force

Write-Output "Jarvis installed globally. Restart Codex to load the agents, skills, and user preferences."
