local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- ─── Font ─────────────────────────────────────────────────────────────────────
-- MesloLGS NF is required for Powerlevel10k icons
config.font = wezterm.font('MesloLGS NF', { weight = 'Regular' })
config.font_size = 13.0
config.line_height = 1.2

-- ─── Colors (Night Owl — matches VSCode and k9s theme) ────────────────────────
config.colors = {
  foreground    = '#d6deeb',
  background    = '#011627',
  cursor_bg     = '#80a4c2',
  cursor_border = '#80a4c2',
  cursor_fg     = '#011627',
  selection_bg  = '#1d3b53',
  selection_fg  = '#d6deeb',

  ansi = {
    '#1b2b34', -- black
    '#ff5874', -- red
    '#addb67', -- green
    '#ecc48d', -- yellow
    '#82aaff', -- blue
    '#c792ea', -- purple
    '#7fdbca', -- cyan
    '#d6deeb', -- white
  },
  brights = {
    '#637777', -- bright black (comments)
    '#ff869a', -- bright red
    '#d7f05a', -- bright green
    '#ffd580', -- bright yellow
    '#82aaff', -- bright blue
    '#e9a3f0', -- bright purple
    '#80cbc4', -- bright cyan
    '#ffffff',  -- bright white
  },

  tab_bar = {
    background = '#01111d',
    active_tab = {
      bg_color = '#82aaff',
      fg_color = '#011627',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#01111d',
      fg_color = '#637777',
    },
    inactive_tab_hover = {
      bg_color = '#1d3b53',
      fg_color = '#d6deeb',
    },
    new_tab = {
      bg_color = '#01111d',
      fg_color = '#637777',
    },
    new_tab_hover = {
      bg_color = '#1d3b53',
      fg_color = '#7fdbca',
    },
  },
}

-- ─── Window ───────────────────────────────────────────────────────────────────
config.window_padding = {
  left   = 14,
  right  = 14,
  top    = 10,
  bottom = 10,
}
config.window_background_opacity  = 0.95
config.macos_window_background_blur = 20
config.window_decorations = 'RESIZE'         -- hide title bar, keep resize border
config.initial_cols = 220
config.initial_rows = 50

-- ─── Tab bar ──────────────────────────────────────────────────────────────────
config.enable_tab_bar        = true
config.use_fancy_tab_bar     = false          -- use retro tab bar (matches color config above)
config.tab_bar_at_bottom     = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width         = 36

-- Show useful context in tab titles
wezterm.on('format-tab-title', function(tab)
  local pane  = tab.active_pane
  local title = pane.title
  -- Trim long titles
  if #title > 32 then
    title = title:sub(1, 30) .. '…'
  end
  return ' ' .. title .. ' '
end)

-- ─── Cursor ───────────────────────────────────────────────────────────────────
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate    = 500

-- ─── Scrollback ───────────────────────────────────────────────────────────────
config.scrollback_lines = 10000

-- ─── Bell ─────────────────────────────────────────────────────────────────────
config.audible_bell = 'Disabled'

-- ─── Performance ──────────────────────────────────────────────────────────────
config.animation_fps = 60
config.max_fps       = 60

-- ─── Shell ────────────────────────────────────────────────────────────────────
config.default_prog = { '/bin/zsh', '-l' }

-- ─── Keybindings ──────────────────────────────────────────────────────────────
config.keys = {
  -- Search — keeps your familiar Cmd+F muscle memory
  { key = 'f', mods = 'CMD',       action = act.Search { CaseInSensitiveString = '' } },

  -- Pane splitting
  { key = 'd', mods = 'CMD',       action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'CMD|SHIFT', action = act.SplitVertical   { domain = 'CurrentPaneDomain' } },

  -- Pane navigation
  { key = '[', mods = 'CMD',       action = act.ActivatePaneDirection 'Prev' },
  { key = ']', mods = 'CMD',       action = act.ActivatePaneDirection 'Next' },

  -- Pane zoom (focus current pane full screen)
  { key = 'z', mods = 'CMD',       action = act.TogglePaneZoomState },

  -- Copy mode — vim-like scrollback navigation and search
  { key = 'u', mods = 'CMD',       action = act.ActivateCopyMode },

  -- Clear scrollback
  { key = 'k', mods = 'CMD',       action = act.ClearScrollback 'ScrollbackAndViewport' },

  -- Font size
  { key = '=', mods = 'CMD',       action = act.IncreaseFontSize },
  { key = '-', mods = 'CMD',       action = act.DecreaseFontSize },
  { key = '0', mods = 'CMD',       action = act.ResetFontSize },

  -- Tab management
  { key = 't', mods = 'CMD',       action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CMD',       action = act.CloseCurrentTab { confirm = false } },
  { key = '1', mods = 'CMD',       action = act.ActivateTab(0) },
  { key = '2', mods = 'CMD',       action = act.ActivateTab(1) },
  { key = '3', mods = 'CMD',       action = act.ActivateTab(2) },
  { key = '4', mods = 'CMD',       action = act.ActivateTab(3) },
  { key = '5', mods = 'CMD',       action = act.ActivateTab(4) },
}

return config
