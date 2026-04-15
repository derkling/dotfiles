# Gemini CLI Extensions

This directory manages extensions for the Gemini CLI.

## Adding Extensions

Extensions are defined in `GeminiExtensions.<profile>` files, where `<profile>`
is the name of a dotfiles profile (e.g., `general`, `work`).

### Format
Each line in an extension file should be either:
1. A **Git repository URL**: Will be installed via `gemini extensions install`.
2. A **Local path**: Will be linked via `gemini extensions link` (if it exists).

### General Extensions
Add extensions to `GeminiExtensions.general` to have them installed for all
profiles.

### Profile-Specific Extensions
Add extensions to `GeminiExtensions.<profile>` (e.g., `GeminiExtensions.work`)
to have them installed only when that profile is active (defined in
`~/.dotfiles_profile`).

## Installation
Extensions must be manually installed or updated by running the `extensions-sync.sh`
script in this directory:

```bash
cd ~/.config/gemini/
./extensions-sync.sh
```

**Note:** The script expects the `gemini` command to be available in your `PATH`.
On systems where it is aliased, you might need to ensure the alias is exported
or call the script from a shell that has the command available.
