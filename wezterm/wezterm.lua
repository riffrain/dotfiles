local wezterm = require 'wezterm'

wezterm.on('update-right-status', function(window, pane)
  local elements = {};
  local battery_info = '';
  for _, b in ipairs(wezterm.battery_info()) do
    battery_info = string.format('%.0f%%', b.state_of_charge * 100);
    -- if (b.state == 'Charging') then
    --   -- battery_info = battery_info .. wezterm.nerdfonts.pom_external_interruption;
    --   battery_info = battery_info .. wezterm.nerdfonts['mdi_battery_charging'];
    --   -- table.insert(elements, { Foreground = { Color = '#222222' } });
    --   -- table.insert(elements, { Background = { Color = '#90E600' } });
    -- else
    --   -- if (b.state_of_charge <= 0.15) then
    --   --   table.insert(elements, { Foreground = { Color = '#ffffff' } });
    --   --   table.insert(elements, { Background = { Color = '#FF0071' } });
    --   -- elseif (b.state_of_charge <= 0.25 ) then
    --   --   table.insert(elements, { Foreground = { Color = '#222222' } });
    --   --   table.insert(elements, { Background = { Color = '#E9DC57' } });
    --   -- else
    --   --   table.insert(elements, { Foreground = { Color = '#B3B3B3' } });
    --   --   table.insert(elements, { Background = { Color = '#5f5f5f' } });
    --   -- end;
    -- end;
    local battery_icon = 'mdi_battery';
    local battery_per = math.floor(b.state_of_charge * 10) * 10;
    if (b.state == 'Charging') then
      -- battery_icon = battery_icon .. '_charging';
      -- if battery_per <= 20 then
      --   battery_icon = battery_icon .. '_20';
      -- else
      --   battery_icon = battery_icon .. string.format('_%.0f', battery_per);
      -- end
      battery_icon = 'pom_external_interruption';
    else 
      if battery_per == 0 then
        battery_icon = battery_icon .. '_outline';
      elseif battery_per <= 90 then
        battery_icon = battery_icon .. string.format('_%.0f', battery_per);
      end
    end
    -- battery_info = battery_icon;
    battery_info = battery_info .. '' .. wezterm.nerdfonts[battery_icon];
  end;
  table.insert(elements, {Attribute={Intensity="Bold"}});
  table.insert(elements, { Text = '| ' .. battery_info .. ' ' });

  local date = wezterm.strftime('%m/%d %H:%M');
  table.insert(elements, { Foreground = { Color = '#222222' } });
  table.insert(elements, { Background = { Color = '#8a8a8a' } });
  table.insert(elements, { Text = ' ' .. date .. ' ' });

  window:set_right_status(wezterm.format(elements));
end);

local ascii_font_size = 12.0
local non_ascii_font_scale = math.floor(13.3 / ascii_font_size * 10) / 10

return {
  tab_max_width = 1000,
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
  line_height = 1.05,
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
