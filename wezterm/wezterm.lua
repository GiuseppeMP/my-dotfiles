local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local mux = wezterm.mux
local dimmer = { brightness = 0.05, hue = 1, saturation = 0.9 }
local c = {}
config.foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 0.80,
}
config.hide_tab_bar_if_only_one_tab = true
local selected_scheme = "tokyonight_moon";
local scheme = wezterm.get_builtin_color_schemes()[selected_scheme]

local C_ACTIVE_BG = scheme.selection_bg;
local C_ACTIVE_FG = scheme.ansi[6];
local C_BG = scheme.background;
local C_HL_1 = scheme.ansi[5];
local C_HL_2 = scheme.ansi[4];
local C_INACTIVE_FG;
local bg = wezterm.color.parse(scheme.background);
local h, s, l, a = bg:hsla();
if l > 0.5 then
    C_INACTIVE_FG = bg:complement_ryb():darken(0.3);
else
    C_INACTIVE_FG = bg:complement_ryb():lighten(0.3);
end

scheme.tab_bar = {
    background = 'None',
    new_tab = {
        bg_color = 'None',
        fg_color = '#b1ce92',
    },
    active_tab = {
        bg_color = 'None',
        -- fg_color = C_ACTIVE_FG,
        fg_color = '#b1ce92',
    },
    inactive_tab = {
        bg_color = 'None',
        fg_color = C_INACTIVE_FG,
    },
    inactive_tab_hover = {
        bg_color = 'None',
        fg_color = C_INACTIVE_FG,
    }
}
config.color_schemes = {
    [selected_scheme] = scheme
}

config.color_scheme = selected_scheme

-- config.dpi = 144
config.dpi_by_screen = {
    ['Built-in Retina Display'] = 144, -- You can omit this if you don't need to change it
    ['LG HDR WQHD'] = 109,
}
config.window_decorations = "RESIZE"
config.font_size = 13
config.native_macos_fullscreen_mode = false
config.animation_fps = 0
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_rate = 800
config.cursor_blink_ease_out = 'Constant'
config.use_fancy_tab_bar = false
config.font = wezterm.font {
    family = 'Inconsolata LGC Nerd Font',
    harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
}

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = ' ' .. wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

config.keys = {
    {
        key = 'f',
        mods = 'LEADER',
        action = wezterm.action.ToggleFullScreen,
    },
    -- CMD-y starts `top` in a new window
    {
        key = 'x',
        mods = 'LEADER',
        action = wezterm.action.SpawnCommandInNewWindow {
            args = { 'htop' },
        },
    },
    {
        key = 'q',
        mods = 'LEADER',
        action = wezterm.action.CloseCurrentTab { confirm = true },
    },
    {
        key = 't',
        mods = 'LEADER',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
}
config.leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 5001 }
wezterm.on('gui-startup', function(cmd)
    -- local _tab, _pane, window = mux.spawn_window(cmd or {})
    -- _pane:send_text('zellij a welcome \n')
    -- useful to load startup scripts
    -- window:gui_window():toggle_fullscreen()
    -- os.execute('open -g "rectangle://execute-action?maximize"')
    -- window:gui_window():maximize()
end)
config.window_padding = {
    left = 5,
    right = 0,
    top = 0,
    bottom = 5,
}
config.window_background_opacity = 100
config.window_background_image_hsb = {
    brightness = 0.5,
    hue = 1.0,
    saturation = 1.0,
}
config.window_background_gradient = {
    -- Can be "Vertical" or "Horizontal".  Specifies the direction
    -- in which the color gradient varies.  The default is "Horizontal",
    -- with the gradient going from left-to-right.
    -- Linear and Radial gradients are also supported; see the other
    -- examples below
    orientation = 'Vertical',

    -- Specifies the set of colors that are interpolated in the gradient.
    -- Accepts CSS style color specs, from named colors, through rgb
    -- strings and more
    colors = {
        '#0f0c29',
        '#302b63',
        '#24243e',
    },

    -- Instead of specifying `colors`, you can use one of a number of
    -- predefined, preset gradients.
    -- A list of presets is shown in a section below.
    -- preset = "Warm",

    -- Specifies the interpolation style to be used.
    -- "Linear", "Basis" and "CatmullRom" as supported.
    -- The default is "Linear".
    interpolation = 'Linear',

    -- How the colors are blended in the gradient.
    -- "Rgb", "LinearRgb", "Hsv" and "Oklab" are supported.
    -- The default is "Rgb".
    blend = 'Rgb',

    -- To avoid vertical color banding for horizontal gradients, the
    -- gradient position is randomly shifted by up to the `noise` value
    -- for each pixel.
    -- Smaller values, or 0, will make bands more prominent.
    -- The default value is 64 which gives decent looking results
    -- on a retina macbook pro display.
    -- noise = 64,

    -- By default, the gradient smoothly transitions between the colors.
    -- You can adjust the sharpness by specifying the segment_size and
    -- segment_smoothness parameters.
    -- segment_size configures how many segments are present.
    -- segment_smoothness is how hard the edge is; 0.0 is a hard edge,
    -- 1.0 is a soft edge.

    -- segment_size = 11,
    -- segment_smoothness = 0.0,
}

config.colors = {
    selection_fg = 'none',
    selection_bg = 'rgba(50% 50% 50% 50%)',
    -- scrollbar_thumb = 'None'
}
config.enable_scroll_bar = true
-- config.min_scroll_bar_height = '1cell'

c.background = {
    -- This is the deepest/back-most layer. It will be rendered first
    {
        source = {
            File = '/Users/giuseppemp/.config/wezterm/bg/alien_ship/spaceship_bg_1.png',
        },
        -- The texture tiles vertically but not horizontally.
        -- When we repeat it, mirror it so that it appears "more seamless".
        -- An alternative to this is to set `width = "100%"` and have
        -- it stretch across the display
        repeat_x = 'Mirror',
        hsb = dimmer,
        -- When the viewport scrolls, move this layer 10% of the number of
        -- pixels moved by the main viewport. This makes it appear to be
        -- further behind the text.
        attachment = { Parallax = 0.1 },
    },
    -- Subsequent layers are rendered over the top of each other
    {
        source = {
            File = '/Users/giuseppemp/.config/wezterm/bg/alien_ship/overlay_1_spines.png',
        },
        width = '100%',
        repeat_x = 'NoRepeat',

        -- position the spins starting at the bottom, and repeating every
        -- two screens.
        vertical_align = 'Bottom',
        repeat_y_size = '200%',
        hsb = dimmer,

        -- The parallax factor is higher than the background layer, so this
        -- one will appear to be closer when we scroll
        attachment = { Parallax = 0.2 },
    },
    {
        source = {
            File = '/Users/giuseppemp/.config/wezterm/bg/alien_ship/overlay_2_alienball.png',
        },
        width = '100%',
        repeat_x = 'NoRepeat',

        -- start at 10% of the screen and repeat every 2 screens
        vertical_offset = '10%',
        repeat_y_size = '200%',
        hsb = dimmer,
        attachment = { Parallax = 0.3 },
    },
    {
        source = {
            File = '/Users/giuseppemp/.config/wezterm/bg/alien_ship/overlay_3_lobster.png',
        },
        width = '100%',
        repeat_x = 'NoRepeat',

        vertical_offset = '30%',
        repeat_y_size = '200%',
        hsb = dimmer,
        attachment = { Parallax = 0.4 },
    },
    {
        source = {
            File = '/Users/giuseppemp/.config/wezterm/bg/alien_ship/overlay_4_spiderlegs.png',
        },
        width = '100%',
        repeat_x = 'NoRepeat',

        vertical_offset = '50%',
        repeat_y_size = '150%',
        hsb = dimmer,
        attachment = { Parallax = 0.5 },
    },
}


-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.active_pane.title
end

wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
        local edge_background = 'none'
        local background = 'none'
        local foreground = '#808080'

        if tab.is_active then
            background = 'none'
            foreground = '#b1ce92'
        elseif hover then
            background = '#3b3052'
            foreground = '#b1ce92'
        end

        local edge_foreground = background

        local title = tab_title(tab)

        return {
            { Background = { Color = 'None' } },
            { Foreground = { Color = foreground } },
            { Text = ' ' .. title .. ' ' },
        }
    end
)

return config
