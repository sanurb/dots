## Setup

```bash
WIP
```

### Git Setup

> [!IMPORTANT]
> Make sure to change the `user.name` in the `git/install.sh` file.

```bash
curl -fsSL https://raw.githubusercontent.com/sanurb/dots/main/config/git/install.sh | bash
```

if you want to use [semantic commits](https://www.conventionalcommits.org/en), run the following command:

```bash
curl -fsSL https://raw.githubusercontent.com/sanurb/dots/main/config/git/semantic-commits.sh | bash
```

This will register Git aliases for commonly used commit types such as `feat`, `fix`, `chore`, and more.

## Available Aliases

- **Semantic Commit Types**:
  - `feat`: Feature development
  - `fix`: Bug fixes
  - `chore`: Routine tasks or updates
  - `docs`: Documentation changes
  - `refactor`: Code refactoring without changing behavior
  - `style`: Code style changes (formatting, missing semicolons)
  - `test`: Adding or updating tests
  - `perf`: Performance improvements
  - `localize`: Localization changes

- **Compatibility Aliases**:
  - Shortcuts like `f` for `feat`, `x` for `fix`, `rf` for `refactor`, and more.

## Example Usage

To use the semantic commit aliases, simply run:

```bash
git f "my feature description"
# This is equivalent to: git commit -m "feat: my feature description"
```

For a detailed guide on semantic commits, visit [git-semantic-commits](https://github.com/fteem/git-semantic-commits).

Uninstall semantic commits:

```bash
curl -fsSL https://raw.githubusercontent.com/sanurb/dots/main/config/git/uninstall-semantic.sh | bash
```

### Keybindings

Here are some keybindings that I use:

- [Vimium](./docs/vimium.md)
- [VSCode](./docs/vscode.md)
- [WezTerm](./docs/wezterm.md)
