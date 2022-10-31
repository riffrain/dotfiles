local wezterm = require 'wezterm'

local ascii_font_size = 12.0
local non_ascii_font_scale = math.floor(14.0 / ascii_font_size * 10) / 10

return {
  font = wezterm.font_with_fallback {
    {
      family = 'Fira Code',
      harfbuzz_features = { 'zero' },
    },
    {
      family = 'Ricty Nerd Font',
      scale = non_ascii_font_scale,
    },
    {
      family = 'Migu 1M',
      scale = non_ascii_font_scale,
    },
  },
  font_size = ascii_font_size,
  use_ime = true,
  color_scheme = 'Monokai (terminal.sexy)',
  tab_bar_at_bottom = false,
  use_fancy_tab_bar = false,
  colors = {
    split = '#666666',
    tab_bar = {
      background = '#222222',
      active_tab = {
        bg_color = '#444444',
        fg_color = '#ffffff',
      },
      inactive_tab = {
        bg_color = '#222222',
        fg_color = '#808080',
      },
      inactive_tab_hover = {
        bg_color = '#222222',
        fg_color = '#ffffff',
        italic = false,
      },
      new_tab = {
        bg_color = '#222222',
        fg_color = '#808080',
      },
      new_tab_hover = {
        bg_color = '#222222',
        fg_color = '#ffffff',
        italic = false,
      },
    },
  },
  enable_scroll_bar = true,
  native_macos_fullscreen_mode = true,
  initial_cols = 140,
  initial_rows = 50,
  window_padding = {
    left = 15,
    right = 15,
    top = 15,
    bottom = 15,
  },
  keys = {
    {
      key = '¥',
      action = wezterm.action.SendString '\\',
    },
    {
      key = '¥',
      mods = 'OPT',
      action = wezterm.action.SendString '\\',
    },
    {
      key = 'd',
      mods = 'CMD',
      action = wezterm.action.SplitHorizontal,
    },
    {
      key = 'd',
      mods = 'CMD|SHIFT',
      action = wezterm.action.SplitVertical,
    },
    {
      key = 'Enter',
      mods = 'CMD',
      action = wezterm.action.ToggleFullScreen,
    },
    {
      key = '¥',
      mods = 'CMD',
      action = wezterm.action.PaneSelect,
    },
  },
  mouse_bindings = {
    {
      event = {
        Up = { streak = 1, button = 'Left' },
      },
      mods = 'NONE',
      action = wezterm.action.CompleteSelection('PrimarySelection'),
    },
    {
      event = {
        Up = { streak = 1, button = 'Left' },
      },
      mods = 'CMD',
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
    {
      event = {
        Down = { streak = 1, button = 'Left' },
      },
      mods = 'CMD',
      action = wezterm.action.Nop,
    },
  },
}
