### Documentation for VSCode Vim Configuration and Keybindings

This documentation provides a detailed overview of the custom keybindings and settings configured in VSCode. The configurations are designed to enhance productivity by enabling efficient navigation, editing, and file management through Vim motions and custom keybindings.

**Table of Contents**

1. [Overview](#overview)
2. [Vim Keybindings in `settings.json`](#vim-keybindings-in-settingsjson)
    - [Leader Key](#leader-key)
    - [Buffer Navigation](#buffer-navigation)
    - [Split Windows](#split-windows)
    - [Pane Navigation](#pane-navigation)
    - [File Management](#file-management)
    - [Quick Actions](#quick-actions)
    - [Diagnostic Navigation](#diagnostic-navigation)
    - [Code Actions](#code-actions)
    - [Document Formatting](#document-formatting)
    - [Hover Actions](#hover-actions)
    - [Visual Mode Keybindings](#visual-mode-keybindings)
3. [Keybindings in `keybindings.json`](#keybindings-in-keybindingsjson)
    - [Navigation](#navigation)
    - [File Tree Management](#file-tree-management)
    - [Additional Keybindings](#additional-keybindings)
4. [Configuration Files](#configuration-files)
5. [Additional Resources](#additional-resources)

---

### Overview

This documentation consolidates the Vim settings and additional keybindings in VSCode. These settings and keybindings aim to optimize a mouseless development workflow by leveraging the power of Vim motions along with custom shortcuts for file and folder management, terminal navigation, and more.

### Vim Keybindings in `settings.json`

#### Leader Key

The **leader key** is configured as `<Space>`. All commands prefixed with the leader key can be triggered by first pressing the spacebar.

```json
"vim.leader": "<Space>",
```

#### Keybindings Overview

| Keybinding                   | Action Description                       |
|------------------------------|------------------------------------------|
| `Shift + h`                  | Switch to the previous buffer            |
| `Shift + l`                  | Switch to the next buffer                |
| `Space + v`                  | Vertical split                           |
| `Space + s`                  | Horizontal split                         |
| `Space + h`                  | Focus left pane                          |
| `Space + j`                  | Focus below pane                         |
| `Space + k`                  | Focus above pane                         |
| `Space + l`                  | Focus right pane                         |
| `Space + w`                  | Save current file                        |
| `Space + q`                  | Quit current file                        |
| `Space + x`                  | Save and close current file              |
| `[ d`                        | Go to the previous diagnostic            |
| `] d`                        | Go to the next diagnostic                |
| `Space + c + a`              | Show code actions (quick fix)            |
| `Space + f`                  | Quick open                               |
| `Space + p`                  | Format document                          |
| `g h`                        | Show definition preview hover            |

#### Visual Mode Keybindings

| Keybinding                   | Action Description                       |
|------------------------------|------------------------------------------|
| `<`                          | Outdent selected lines                   |
| `>`                          | Indent selected lines                    |
| `J`                          | Move selected lines down                 |
| `K`                          | Move selected lines up                   |
| `Space + c`                  | Toggle comment on the selection          |

### Keybindings in `keybindings.json`

These keybindings are configured in `keybindings.json` and provide additional functionality for managing files, navigating the terminal, and more.

#### Navigation

| Keybinding                   | Action Description                       |
|------------------------------|------------------------------------------|
| `Ctrl + Shift + A`           | Focus next terminal                      |
| `Ctrl + Shift + B`           | Focus previous terminal                  |
| `Ctrl + Shift + J`           | Toggle terminal panel                    |
| `Ctrl + Shift + N`           | Open new terminal                        |
| `Ctrl + Shift + W`           | Kill current terminal                    |

#### File Tree Management

| Keybinding                   | Action Description                       |
|------------------------------|------------------------------------------|
| `Ctrl + E`                   | Toggle sidebar visibility / focus files  |
| `n`                          | Create a new file                        |
| `r`                          | Rename a file                            |
| `Shift + N`                  | Create a new folder / open new window    |
| `d`                          | Delete a file                            |

#### Additional Keybindings

| Keybinding                   | Action Description                       |
|------------------------------|------------------------------------------|
| `Ctrl + Shift + 5`           | Match Emmet tag                          |
| `Ctrl + Alt + Z`             | Toggle Zen mode                          |

### Configuration Files

You can find the detailed configuration in the following files:

- [settings.json](../config/vscode/settings.json)
- [keybindings.json](../config/vscode/keybindings.json)

### Additional Resources

- **[Mastering VIM Motions in VSCode (Mouseless development)](https://www.youtube.com/watch?v=GST8we5uABo)**
- **[THE BEST VIM CONFIG FOR VSCODE | configure vscode like vim](https://www.youtube.com/watch?v=Vkm4bc2Y0AA)**
