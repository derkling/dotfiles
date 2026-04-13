# GEMINI.md - Operational Mandates

This file provides critical operational constraints for LLM agents working on
this repository. For architectural details, directory structure, and the
"Split Configuration Strategy", refer to the **README.md**.

## 1. Management Workflow (MANDATORY)
- **Tooling**: NEVER use standard `git` commands. ALWAYS use the `config`
  alias (e.g., `config status`, `config add`, `config commit`).
- **Permissions**: This is a bare repository. Modifications happen directly in
  `$HOME` or `~/.config`.

## 2. Commit Message Standards
- **Format**: Reflow all messages to 78 characters.
- **Structure**: [Prefix] Descriptive subject line, followed by an empty line,
  and a detailed imperative changelog.
- **Tone**: Use imperative tone (e.g., "Add feature" not "Added feature").
- **Prefixes**: Use bracketed prefixes based on the component: `[Shell]`,
  `[Fish]`, `[Sway]`, `[NVim]`, `[Config]`, `[SSH]`, `[Docs]`.

## 3. Environment Awareness (Toolbox/Atomic)
- **Detection**: Check `/run/.containerenv` or `VARIANT_ID=toolbx` in
  `/etc/os-release`.
- **Host Access**: If in a toolbox, the host rootfs is at `/run/host`.
- **Command Execution**:
    - Use `flatpak-spawn --host` for minor host-side actions (e.g.,
      `rpm-ostree status`, `systemctl` checks).
    - For system-level modifications (e.g., `rpm-ostree install`), propose the
      command to the user and ask them to run it on the host.

## 4. Subsystem Rules
- **Systemd**: Never modify `/usr/lib/systemd/`. Always use user-specific
  drop-in overrides in `~/.config/systemd/user/<service>.service.d/`.
- **Fish Shell**:
    - Place `bind` commands *after* `fish_vi_key_bindings` in `config.fish`.
    - Use `fish -c '<command>'` for non-interactive testing.
- **Neovim**: `make -C ~/.config clean-nvim` is available for cache purging.

## 5. Diagnostic Commands
- `sanity-check`: Run the system health check tool.
- `make bootstrap`: Unified provisioning for both Fedora Atomic and Debian.
- `config diff`: Review pending changes before committing.
