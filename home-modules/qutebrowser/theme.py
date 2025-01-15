    # vim:fileencoding=utf-8:foldmethod=marker

palette = {
    'fg': '#d3c6aa',
    'red': '#e67e80',
    'orange': '#e69875',
    'yellow': '#dbbc7f',
    'green': '#a7c080',
    'aqua': '#83c092',
    'blue': '#7fbbb3',
    'purple': '#d699b6',
    'grey0': '#7a8478',
    'grey1': '#859289',
    'grey2': '#9da9a0',
    'statusline1': '#a7c080',
    'statusline2': '#d3c6aa',
    'statusline3': '#e67e80',
    'bg_dim': '#1e2326',
    'bg0': '#272e33',
    'bg1': '#2e383c',
    'bg2': '#374145',
    'bg3': '#414b50',
    'bg4': '#495156',
    'bg5': '#4f5b58',
    'bg_visual': '#4c3743',
    'bg_red': '#493b40',
    'bg_green': '#3c4841',
    'bg_blue': '#384b55',
    'bg_yellow': '#45443c',
}

def setup(c):
    c.colors.webpage.bg = palette['bg0']

    c.colors.keyhint.fg = palette['fg']
    c.colors.keyhint.suffix.fg = palette['red']

    c.colors.messages.error.bg = palette['bg_red']
    c.colors.messages.error.fg = palette['fg']
    c.colors.messages.info.bg = palette['bg_blue']
    c.colors.messages.info.fg = palette['fg']
    c.colors.messages.warning.bg = palette['bg_yellow']
    c.colors.messages.warning.fg = palette['fg']

    c.colors.prompts.bg = palette['bg0']
    c.colors.prompts.fg = palette['fg']

    c.colors.completion.category.bg = palette['bg0']
    c.colors.completion.category.fg = palette['fg']
    c.colors.completion.fg = palette['fg']
    c.colors.completion.even.bg = palette['bg0']
    c.colors.completion.odd.bg = palette['bg1']
    c.colors.completion.match.fg = palette['red']
    c.colors.completion.item.selected.fg = palette['fg']
    c.colors.completion.item.selected.bg = palette['bg_yellow']
    c.colors.completion.item.selected.border.top = palette['bg_yellow']
    c.colors.completion.item.selected.border.bottom = palette['bg_yellow']

    c.colors.completion.scrollbar.bg = palette['bg_dim']
    c.colors.completion.scrollbar.fg = palette['fg']

    c.colors.hints.bg = palette['bg0']
    c.colors.hints.fg = palette['fg']
    c.colors.hints.match.fg = palette['red']
    c.hints.border = '0px solid black'

    c.colors.statusbar.normal.fg = palette['fg']
    c.colors.statusbar.normal.bg = palette['bg3']

    c.colors.statusbar.insert.fg = palette['bg0']
    c.colors.statusbar.insert.bg = palette['statusline1']

    c.colors.statusbar.command.fg = palette['fg']
    c.colors.statusbar.command.bg = palette['bg0']

    c.colors.statusbar.url.error.fg = palette['orange']
    c.colors.statusbar.url.fg = palette['fg']
    c.colors.statusbar.url.hover.fg = palette['blue']
    c.colors.statusbar.url.success.http.fg = palette['green']
    c.colors.statusbar.url.success.https.fg = palette['green']

    c.colors.tabs.bar.bg = palette['bg_dim']
    c.colors.tabs.even.bg = palette['bg0']
    c.colors.tabs.odd.bg = palette['bg0']
    c.colors.tabs.even.fg = palette['fg']
    c.colors.tabs.odd.fg = palette['fg']
    c.colors.tabs.selected.even.bg = palette['bg2']
    c.colors.tabs.selected.odd.bg = palette['bg2']
    c.colors.tabs.selected.even.fg = palette['fg']
    c.colors.tabs.selected.odd.fg = palette['fg']
    c.colors.tabs.indicator.start = palette['blue']
    c.colors.tabs.indicator.stop = palette['green']
    c.colors.tabs.indicator.error = palette['red']
