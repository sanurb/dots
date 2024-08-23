-- Import the wezterm API
local wezterm = require("wezterm")

-- Function to configure colors
local function get_color_scheme()
  return {
    foreground = "#dcd7ba",
    background = "#181616",
    cursor_bg = "#c8c093",
    cursor_fg = "#c8c093",
    cursor_border = "#c8c093",
    selection_fg = "#c8c093",
    selection_bg = "#2d4f67",
    scrollbar_thumb = "#16161d",
    split = "#16161d",
    ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
    brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
    indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
  }
end

-- Function to configure key bindings for tmux-like behavior
local function get_key_bindings()
  local keys = {
    { mods = "LEADER", key = "c", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { mods = "LEADER", key = "x", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
    { mods = "LEADER", key = "b", action = wezterm.action.ActivateTabRelative(-1) },
    { mods = "LEADER", key = "n", action = wezterm.action.ActivateTabRelative(1) },
    { mods = "LEADER", key = "|", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { mods = "LEADER", key = "-", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { mods = "LEADER", key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
    { mods = "LEADER", key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
    { mods = "LEADER", key = "k", action = wezterm.action.ActivatePaneDirection("Up") },
    { mods = "LEADER", key = "l", action = wezterm.action.ActivatePaneDirection("Right") },
    { mods = "LEADER", key = "LeftArrow", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
    { mods = "LEADER", key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
    { mods = "LEADER", key = "DownArrow", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
    { mods = "LEADER", key = "UpArrow", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
    { mods = "LEADER", key = "r", action = wezterm.action.ReloadConfiguration },
    { mods = "LEADER", key = "f", action = wezterm.action.ShowLauncher },
    -- Toggle Zen Mode (hide/show the tab bar and other UI elements)
    {
      mods = "LEADER",
      key = "z",
      action = wezterm.action_callback(function(window, _)
        local overrides = window:get_config_overrides() or {}
        if not overrides.hide_tab_bar_if_only_one_tab then
          overrides.hide_tab_bar_if_only_one_tab = true
          overrides.window_decorations = "NONE"
        else
          overrides.hide_tab_bar_if_only_one_tab = false
          overrides.window_decorations = "RESIZE"
        end
        window:set_config_overrides(overrides)
      end),
    },
  }

  -- Add key bindings for activating tabs with leader + number
  for i = 0, 9 do
    table.insert(keys, {
      key = tostring(i),
      mods = "LEADER",
      action = wezterm.action.ActivateTab(i),
    })
  end

  return keys
end

-- Function to configure the tmux-like status
local function configure_tmux_status(window)
  local SOLID_LEFT_ARROW = ""
  local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
  local prefix = ""

  if window:leader_is_active() then
    prefix = " " .. utf8.char(0x1f30a) -- Ocean wave emoji when leader is active
    SOLID_LEFT_ARROW = utf8.char(0xe0b2) -- Solid left arrow
  end

  if window:active_tab():tab_id() ~= 0 then
    ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
  end -- Arrow color changes based on active tab

  window:set_left_status(wezterm.format({
    { Background = { Color = "#b7bdf8" } },
    { Text = prefix },
    ARROW_FOREGROUND,
    { Text = SOLID_LEFT_ARROW },
  }))
end

-- Main configuration table
local config = wezterm.config_builder and wezterm.config_builder() or {}

if wezterm.target_triple:find("windows") then
  config.default_prog = { "wsl.exe" }
end

-- Apply color scheme
config.colors = get_color_scheme()

-- Window configuration
config.window_decorations = "RESIZE" -- Removes window title bar
config.force_reverse_video_cursor = true
config.window_background_opacity = 0.95
config.font = wezterm.font("CaskaydiaMono Nerd Font")
config.hide_tab_bar_if_only_one_tab = true

-- Key bindings and tmux-like behavior
config.leader = { key = "q", mods = "ALT", timeout_milliseconds = 2000 }
config.keys = get_key_bindings()



-- Tab bar configuration
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

-- Event handler for tmux-like status
wezterm.on("update-right-status", function(window, _)
  configure_tmux_status(window)
end)

-- Helper function to extract the base name from a path
local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

-- Function to format the tab title based on the active pane
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local active = tab.is_active
  local hover = hover
  local index = tab.tab_index
  local process_name = tab.active_pane.foreground_process_name
  local exec_name = basename(process_name)
  local title_prefix = active and "󰅬 " or ""
  local background = active and "#83c092" or hover and "#5c6a72" or "#4e565b"
  local foreground = "#1c1f24"

  return {
    { Text = string.format(" %d: %s%s ", index + 1, title_prefix, wezterm.truncate_right(exec_name, max_width - 8)) },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
  }
end)

-- Return the configuration to wezterm
return config
