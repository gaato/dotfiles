local wezterm = require 'wezterm';
return {
  -- font
  font = wezterm.font_with_fallback({
    -- {family="Intel One Mono", weight="Medium"},
    {family="HackGen Console NF", weight="Medium"},
    -- {family="IBM Plex Sans JP", weight="Medium"},
    -- {family="Source Han Sans JP"},
  }),
  font_size = 11.0,
  color_scheme = "iceberg-dark",
  
  -- DPI and scaling settings
  dpi = nil, -- Let WezTerm auto-detect DPI

  -- padding (small padding can help with rendering on high-DPI)
  window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
  },

  -- tab bar
  use_fancy_tab_bar = false,
  colors = {
    cursor_bg= "#c6c8d1",
    tab_bar = {
      background = "#1b1f2f",

      active_tab = {
        bg_color = "#444b71",
        fg_color = "#c6c8d1",
        intensity = "Normal",
        underline = "None",
        italic = false,
        strikethrough = false,
      },

      inactive_tab = {
        bg_color = "#282d3e",
        fg_color = "#c6c8d1",
        intensity = "Normal",
        underline = "None",
        italic = false,
        strikethrough = false,
      },

      inactive_tab_hover = {
        bg_color = "#1b1f2f",
        fg_color = "#c6c8d1",
        intensity = "Normal",
        underline = "None",
        italic = true,
        strikethrough = false,
      },

      new_tab = {
        bg_color = "#1b1f2f",
        fg_color = "#c6c8d1",
        italic = false
      },

      new_tab_hover = {
        bg_color = "#444b71",
        fg_color = "#c6c8d1",
        italic = false
      },
    }
  },

  -- background (reduced opacity for better stability on high-DPI)
  window_background_opacity = 0.95,
  
  -- Additional stability settings for multi-monitor setups
  enable_wayland = false, -- Disable if using Wayland and experiencing issues
  front_end = "OpenGL", -- More stable than WebGpu on some systems

  -- key
  keys = {
    {key = "{", mods = "CTRL", action=wezterm.action{ActivateTabRelative=-1}},
    {key = "}", mods = "CTRL", action=wezterm.action{ActivateTabRelative=1}},
    {key = "p", mods = "CTRL|SHIFT", action=wezterm.action{ScrollByLine=-1}},
    {key = "n", mods = "CTRL|SHIFT", action=wezterm.action{ScrollByLine=1}},
    {key = "b", mods = "CTRL|SHIFT", action=wezterm.action{ScrollByPage=-1}},
    {key = "f", mods = "CTRL|SHIFT", action=wezterm.action{ScrollByPage=1}},
  },

  --title
  wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    return {
      {Text=" " .. tab.active_pane.title .. " "},
    }
  end),

  -- shell
  default_prog = {"zsh", "--login"},
}
