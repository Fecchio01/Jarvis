#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
codex_home="${CODEX_HOME:-$HOME/.codex}"
skills_home="$HOME/.agents/skills"
agents_home="$codex_home/agents"
global_agents="$codex_home/AGENTS.md"
begin_marker="<!-- BEGIN JARVIS MANAGED GLOBAL INSTRUCTIONS -->"
end_marker="<!-- END JARVIS MANAGED GLOBAL INSTRUCTIONS -->"

mkdir -p "$codex_home" "$agents_home" "$skills_home"

python3 - "$global_agents" "$repo_root/AGENTS.md" "$begin_marker" "$end_marker" <<'PY'
from pathlib import Path
import re
import sys

target = Path(sys.argv[1])
source = Path(sys.argv[2])
begin, end = sys.argv[3], sys.argv[4]
current = target.read_text(encoding="utf-8") if target.exists() else ""
managed = source.read_text(encoding="utf-8").strip()
block = f"{begin}\n{managed}\n{end}"
pattern = re.compile(re.escape(begin) + r".*?" + re.escape(end), re.DOTALL)

if pattern.search(current):
    result = pattern.sub(lambda _: block, current)
else:
    result = f"{current.rstrip()}\n\n{block}\n" if current.strip() else f"{block}\n"

target.parent.mkdir(parents=True, exist_ok=True)
target.write_text(result, encoding="utf-8")
PY

cp -R "$repo_root/.codex/agents/." "$agents_home/"
cp "$repo_root/.codex/USER-PREFERENCES.md" "$codex_home/USER-PREFERENCES.md"
cp -R "$repo_root/.agents/skills/." "$skills_home/"

printf 'Jarvis installed globally. Restart Codex to load the agents, skills, and user preferences.\n'
