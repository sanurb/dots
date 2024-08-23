-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0

-- Check if running inside WSL
if vim.fn.has("wsl") == 1 then
  local function setup_wsl_clipboard()
    vim.g.clipboard = {
      name = "win_clipboard",
      copy = {
        ["+"] = "clip.exe",
        ["*"] = "clip.exe",
      },
      paste = {
        ["+"] = "powershell.exe Get-Clipboard",
        ["*"] = "powershell.exe Get-Clipboard",
      },
      cache_enabled = 0,
    }
  end

  if vim.fn.executable("clip.exe") == 1 and vim.fn.executable("powershell.exe") == 1 then
    setup_wsl_clipboard()

    local opts = { noremap = true, silent = true }
    vim.keymap.set({ "n", "v" }, "y", '"+y', opts)
    vim.keymap.set({ "n", "v" }, "p", '"+p', opts)
  else
    vim.api.nvim_echo({ { "Warning: 'clip.exe' or 'powershell.exe' not found!", "WarningMsg" } }, true, {})
  end
end
