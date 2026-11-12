# cd-git-root.yazi

Changes directory to the root of the git repository you are currently in.

Works with git worktrees: inside a linked worktree it jumps to the root of
*that* worktree, not to the main repository or the directory holding all
worktrees.

## Installation

```sh
ya pkg add stexus/cd-repo-root
```

## Usage

Add this to your `~/.config/yazi/keymap.toml`:

```toml
[[mgr.prepend_keymap]]
desc = "Go to repo root"
on   = "b"
run  = "plugin cd-repo-root"

```

## License

This plugin is licensed under GPLv3. For more information please check the [LICENSE](LICENSE) file.
