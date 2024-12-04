local themes_path = require("gears.filesystem").get_themes_dir()
local dpi = require("beautiful.xresources").apply_dpi

-- {{{ Main
local theme = {}
theme.wallpaper = "/home/yehorkhod/.config/awesome/background.png"
-- }}}

-- {{{ Styles
theme.font      = "sans 8"

-- {{{ Colors
theme.fg_normal  = "#e0def4" -- Soft foreground
theme.fg_focus   = "#c4a7e7" -- Highlighted foreground
theme.fg_urgent  = "#eb6f92" -- Urgent foreground
theme.bg_normal  = "#191724" -- Base background
theme.bg_focus   = "#26233a" -- Focused background
theme.bg_urgent  = "#403d52" -- Urgent background
theme.bg_systray = theme.bg_normal -- Systray background
-- }}}

-- {{{ Borders
theme.useless_gap   = dpi(0) -- Small gap for spacing
theme.border_width  = dpi(2)
theme.border_normal = "#403d52" -- Inactive border
theme.border_focus  = "#31748f" -- Active border
theme.border_marked = "#eb6f92" -- Marked border
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#26233a" -- Titlebar for focused windows
theme.titlebar_bg_normal = "#191724" -- Titlebar for normal windows
-- }}}

-- {{{ Taglist
theme.taglist_bg_focus = "#9ccfd8" -- Background of active tags
theme.taglist_fg_focus = "#191724" -- Foreground of active tags
theme.taglist_bg_urgent = "#eb6f92" -- Background of urgent tags
theme.taglist_fg_urgent = "#191724" -- Foreground of urgent tags
theme.taglist_bg_empty = "#26233a" -- Background of empty tags
theme.taglist_fg_empty = "#6e6a86" -- Foreground of empty tags
-- }}}

-- {{{ Tasklist
theme.tasklist_bg_focus = "#26233a" -- Tasklist focus background
theme.tasklist_fg_focus = "#e0def4" -- Tasklist focus foreground
-- }}}

-- {{{ Widgets
theme.fg_widget        = "#c4a7e7"
theme.fg_center_widget = "#9ccfd8"
theme.fg_end_widget    = "#f6c177"
theme.bg_widget        = "#26233a"
theme.border_widget    = "#403d52"
-- }}}

-- {{{ Tooltips
theme.tooltip_fg_color = "#e0def4"
theme.tooltip_bg_color = "#26233a"
theme.tooltip_border_color = "#31748f"
theme.tooltip_border_width = dpi(1)
theme.tooltip_opacity = 0.8
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#eb6f92"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = themes_path .. "zenburn/taglist/squarefz.png"
theme.taglist_squares_unsel = themes_path .. "zenburn/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = themes_path .. "zenburn/awesome-icon.png"
theme.menu_submenu_icon      = themes_path .. "default/submenu.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = themes_path .. "zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = themes_path .. "zenburn/titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active  = themes_path .. "zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path .. "zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = themes_path .. "zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = themes_path .. "zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path .. "zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = themes_path .. "zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = themes_path .. "zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = themes_path .. "zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = themes_path .. "zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = themes_path .. "zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = themes_path .. "zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themes_path .. "zenburn/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
