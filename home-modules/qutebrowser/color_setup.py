def setup(c, colors):
    # Statusbar
    c.colors.statusbar.normal.bg = colors["statusbar"]["normal"]["background"]
    c.colors.statusbar.normal.fg = colors["statusbar"]["normal"]["foreground"]

    c.colors.statusbar.command.bg = colors["statusbar"]["command"]["background"]
    c.colors.statusbar.command.fg = colors["statusbar"]["command"]["foreground"]

    # Tabs
    c.colors.tabs.selected.even.bg = colors["tabs"]["even"]["selected-background"]
    c.colors.tabs.even.bg = colors["tabs"]["even"]["background"]
    c.colors.tabs.even.fg = colors["tabs"]["even"]["foreground"]

    c.colors.tabs.selected.odd.bg = colors["tabs"]["odd"]["selected-background"]
    c.colors.tabs.odd.bg = colors["tabs"]["odd"]["background"]
    c.colors.tabs.odd.fg = colors["tabs"]["odd"]["foreground"]

    c.colors.tabs.indicator.stop = colors["tabs"]["stop-indicator"]

    # Hints
    c.colors.hints.bg = colors["hints"]["background"]
    c.colors.hints.fg = colors["hints"]["foreground"]

    # Completion
    c.colors.completion.even.bg = colors["completion"]["default"]["even-background"]
    c.colors.completion.odd.bg = colors["completion"]["default"]["even-background"]
    c.colors.completion.fg = colors["completion"]["default"]["foreground"]

    c.colors.completion.category.bg = colors["completion"]["category"]["background"]
    c.colors.completion.category.fg = colors["completion"]["category"]["foreground"]

    c.colors.completion.item.selected.bg = colors["completion"]["selected-item"]["background"]
    c.colors.completion.item.selected.fg = colors["completion"]["selected-item"]["foreground"]

    c.colors.webpage.darkmode.enabled = colors["darkmode"]
