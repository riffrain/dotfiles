local wezterm = require 'wezterm'

wezterm.on('update-right-status', function(window, pane)
  local battery_info = '';
  local battery_fg = '#9c9c9c';
  local battery_bg = '#444444';
  for _, b in ipairs(wezterm.battery_info()) do
    battery_info = string.format('%.0f%%', b.state_of_charge * 100);
    local battery_icon = 'mdi_battery';
    if (b.state == 'Charging') then
      battery_icon = battery_icon .. '_charging';
    else
      if b.state_of_charge < 0.1 then
        battery_icon = battery_icon .. '_outline';
      elseif b.state_of_charge <= 0.9 then
        battery_icon = battery_icon .. string.format('_%.0f', math.floor(b.state_of_charge * 10) * 10);
      end

      if b.state_of_charge <= 0.15 then
        battery_bg = '#FF0071'
        battery_fg = '#ffffff'
      end
    end
    battery_info = wezterm.nerdfonts[battery_icon] .. ' ' .. battery_info;
  end
  local date = wezterm.strftime('%m/%d(%a) %H:%M');

  local elements = {};

  table.insert(elements, { Foreground = { Color = '#ACADA1' } });
  table.insert(elements, { Background = { Color = '#303030' } });
  table.insert(elements, { Text = ' ' .. pane:get_domain_name() .. ' ' });

  table.insert(elements, { Foreground = { Color = battery_fg } });
  table.insert(elements, { Background = { Color = battery_bg } });
  table.insert(elements, { Text = ' ' .. battery_info .. ' ' });

  table.insert(elements, { Foreground = { Color = '#222222' } });
  table.insert(elements, { Background = { Color = '#8a8a8a' } });
  table.insert(elements, { Text = ' ' .. date .. ' ' });

  window:set_right_status(wezterm.format(elements));
end)

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab.tab_index + 1 .. ': '
    .. string.gsub(tab.active_pane.foreground_process_name, '(.*[/\\])(.*)', '%2')

  return {
    { Text = ' ' .. title .. ' ' },
  }
end)

local ascii_font_size = 13.0
local non_ascii_font_scale = math.floor(13.3 / ascii_font_size * 100) / 100

return {
  check_for_updates = false,
  tab_max_width = 1000,
  font = wezterm.font_with_fallback {
    {
      family = 'Fira Code',
      harfbuzz_features = { 'zero' },
    },
    {
      family = 'JetBrains Mono',
    },
    {
      family = 'Migu 1M',
      scale = non_ascii_font_scale,
    },
    {
      family = 'Ricty Nerd Font',
      scale = non_ascii_font_scale,
    },
  },
  line_height = 1.1,
  cell_width = 1.0,
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
  enable_scroll_bar = false,
  native_macos_fullscreen_mode = true,
  initial_cols = 140,
  initial_rows = 50,
  window_padding = {
    -- left = 15,
    -- right = 15,
    -- top = 0,
    bottom = 0,
  },
  keys = {
    {
      key = '¥',
      action = wezterm.action.SendString '\\',
    },
    {
      key = '¥',
      mods = 'OPT',
      action = wezterm.action.SendString '¥',
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
    {
      key = 'Enter',
      mods = 'ALT',
      action = wezterm.action.DisableDefaultAssignment,
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
