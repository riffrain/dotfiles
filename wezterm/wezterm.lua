local wezterm = require 'wezterm'

return {
  font = wezterm.font_with_fallback {
    'FiraCode Nerd Font',
    'FiraCode',
    'Migu 1M',
  },
  font_size = 12.0,
  use_ime = true,
  tab_bar_at_bottom = false,
  color_scheme = 'Monokai (terminal.sexy)',
  enable_scroll_bar = true,
  window_padding = {
    left = 5,
    right = 5,
    top = 0,
    bottom = 0,
  },
  keys = {
    {
      key = 'd',
      mods = 'CMD',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'D',
      mods = 'CMD',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'l',
      mods = 'SHIFT',
      action = wezterm.action.Nop,
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
