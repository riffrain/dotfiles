local wezterm = require 'wezterm'

return {
  font = wezterm.font_with_fallback {
    {
      family = 'Fira Code',
      harfbuzz_features = { 'zero' },
    },
    'Migu 1M',
  },
  font_size = 12.0,
  use_ime = true,
  tab_bar_at_bottom = false,
  color_scheme = 'Monokai (terminal.sexy)',
  enable_scroll_bar = true,
  native_macos_fullscreen_mode = true,
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
}
