# dotfiles

`install.sh` is deprecated and should not be used. Use `bootstrap.sh` flags instead.

Bootstrap this machine with the phased installer:

- `./bootstrap.sh --brew` installs Homebrew packages and casks.
- `./bootstrap.sh --dotfiles` applies stow-managed dotfiles.
- `./bootstrap.sh --post` runs post-bootstrap checks and prints a notice for manual steps that still need to be completed.
- `./bootstrap.sh --all` runs the full flow in order.

Recommended workflow:

1. Run `./bootstrap.sh --brew`.
2. Audit current and desired Homebrew state with `scripts/audit-brew.sh`.
3. Apply config links with `./bootstrap.sh --dotfiles`.
4. Run `./bootstrap.sh --post` to get a reminder about required manual post-setup steps.
5. Run `scripts/verify-bootstrap.sh` to print bootstrap verification checks; it exits non-zero when required checks fail, and you can preview checks with `DRY_RUN=1 scripts/verify-bootstrap.sh`.

For repeatable setup on a new machine, use `./bootstrap.sh --all`.
