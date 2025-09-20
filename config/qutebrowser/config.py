# Make LSP stop complaining
config = config  # type: ignore
c = c  # type: ignore

palette = {
    "Base": "#232136",
    "Surface": "#2a273f",
    "Overlay": "#393552",
    "Muted": "#6e6a86",
    "Subtle": "#908caa",
    "Text": "#e0def4",
    "Love": "#eb6f92",
    "Gold": "#f6c177",
    "Rose": "#ea9a97",
    "Pine": "#3e8fb0",
    "Foam": "#9ccfd8",
    "Iris": "#c4a7e7",
    "HighlightLow": "#2a283e",
    "HighlightMed": "#44415a",
    "HighlightHigh": "#56526e",
}


def colors_setup(c, palette):
    ## Background color of the completion widget category headers.
    c.colors.completion.category.bg = palette["Base"]
    ## Bottom border color of the completion widget category headers.
    c.colors.completion.category.border.bottom = palette["Surface"]
    ## Top border color of the completion widget category headers.
    c.colors.completion.category.border.top = palette["Overlay"]
    ## Foreground color of completion widget category headers.
    c.colors.completion.category.fg = palette["Love"]
    ## Background color of the completion widget for even and odd rows.
    c.colors.completion.even.bg = palette["HighlightLow"]
    c.colors.completion.odd.bg = palette["HighlightMed"]
    ## Text color of the completion widget.
    c.colors.completion.fg = palette["Text"]

    ## Background color of the selected completion item.
    c.colors.completion.item.selected.bg = palette["HighlightMed"]
    ## Bottom border color of the selected completion item.
    c.colors.completion.item.selected.border.bottom = palette["Surface"]
    ## Top border color of the completion widget category headers.
    c.colors.completion.item.selected.border.top = palette["Surface"]
    ## Foreground color of the selected completion item.
    c.colors.completion.item.selected.fg = palette["Text"]
    ## Foreground color of the selected completion item.
    c.colors.completion.item.selected.match.fg = palette["Rose"]
    ## Foreground color of the matched text in the completion.
    c.colors.completion.match.fg = palette["Text"]

    ## Color of the scrollbar in completion view
    c.colors.completion.scrollbar.bg = palette["Overlay"]
    ## Color of the scrollbar handle in completion view.
    c.colors.completion.scrollbar.fg = palette["Surface"]

    ## Background color of the statusbar in different modes.
    c.colors.statusbar.normal.bg = palette["Base"]
    c.colors.statusbar.insert.bg = palette["Base"]
    c.colors.statusbar.command.bg = palette["Base"]
    c.colors.statusbar.caret.bg = palette["Base"]
    c.colors.statusbar.caret.selection.bg = palette["Base"]
    c.colors.statusbar.passthrough.bg = palette["Surface"]
    c.colors.statusbar.private.bg = palette["Love"]

    ## Background color of the progress bar.
    c.colors.statusbar.progress.bg = palette["Foam"]

    ## Foreground color of the statusbar in different modes.
    c.colors.statusbar.normal.fg = palette["Rose"]
    c.colors.statusbar.insert.fg = palette["Pine"]
    c.colors.statusbar.command.fg = palette["Love"]
    c.colors.statusbar.passthrough.fg = palette["Subtle"]
    c.colors.statusbar.caret.fg = palette["Overlay"]
    c.colors.statusbar.caret.selection.fg = palette["Iris"]
    c.colors.statusbar.private.fg = palette["HighlightMed"]

    ## Foreground color of the URL in the statusbar on error.
    c.colors.statusbar.url.error.fg = palette["Gold"]

    ## Default foreground color of the URL in the statusbar.
    c.colors.statusbar.url.fg = palette["Text"]

    ## Foreground color of the URL in the statusbar for hovered links.
    c.colors.statusbar.url.hover.fg = palette["Gold"]

    ## Foreground color of the URL in the statusbar on successful load.
    c.colors.statusbar.url.success.http.fg = palette["Subtle"]

    ## Foreground color of the URL in the statusbar on successful load.
    c.colors.statusbar.url.success.https.fg = palette["Subtle"]

    ## Foreground color of the URL in the statusbar when there's a warning.
    c.colors.statusbar.url.warn.fg = palette["Gold"]

    # Background color of unselected tabs.
    c.colors.tabs.bar.bg = palette["Base"]
    c.colors.tabs.even.bg = palette["Base"]
    c.colors.tabs.odd.bg = palette["Base"]

    # Foreground color of unselected tabs.
    c.colors.tabs.even.fg = palette["Subtle"]
    c.colors.tabs.odd.fg = palette["Subtle"]

    # Background color of the selected tab.
    c.colors.tabs.selected.even.bg = palette["HighlightMed"]
    c.colors.tabs.selected.odd.bg = palette["HighlightMed"]

    # Foreground color of the selected tab.
    c.colors.tabs.selected.even.fg = palette["Text"]
    c.colors.tabs.selected.odd.fg = palette["Text"]

    # Color for the tab indicator.
    c.colors.tabs.indicator.error = palette["Gold"]
    c.colors.tabs.indicator.start = palette["Pine"]
    c.colors.tabs.indicator.stop = palette["Rose"]

    # Pinned tabs
    c.colors.tabs.pinned.even.fg = palette["Subtle"]
    c.colors.tabs.pinned.even.bg = palette["Overlay"]
    c.colors.tabs.pinned.odd.fg = palette["Subtle"]
    c.colors.tabs.pinned.odd.bg = palette["Overlay"]
    c.colors.tabs.pinned.selected.even.fg = palette["Text"]
    c.colors.tabs.pinned.selected.even.bg = palette["HighlightMed"]
    c.colors.tabs.pinned.selected.odd.fg = palette["Text"]
    c.colors.tabs.pinned.selected.odd.bg = palette["HighlightMed"]

    c.colors.webpage.bg = palette["Base"]
    c.colors.contextmenu.menu.bg = palette["Surface"]
    c.colors.contextmenu.menu.fg = palette["Text"]

    c.colors.contextmenu.disabled.bg = palette["Muted"]
    c.colors.contextmenu.disabled.fg = palette["Text"]

    c.colors.contextmenu.selected.bg = palette["Rose"]
    c.colors.contextmenu.selected.fg = palette["Base"]

    ## Background color of the keyhint widget.
    c.colors.keyhint.bg = palette["Surface"]

    ## Text color for the keyhint widget.
    c.colors.keyhint.fg = palette["Text"]

    ## Highlight color for keys to complete the current keychain.
    c.colors.keyhint.suffix.fg = palette["Rose"]

    ## Background color of follow hint
    c.colors.hints.bg = palette["Surface"]

    ## Text color for follow hint
    c.colors.hints.fg = palette["Text"]

    ## Highlight color for keys to complete the current keychain.
    c.colors.hints.match.fg = palette["Rose"]

    ## Border for follow hint
    c.hints.border = f"1px solid {palette['Overlay']}"

    c.colors.downloads.bar.bg = palette["Base"]
    c.colors.downloads.error.bg = palette["Base"]
    c.colors.downloads.start.bg = palette["Base"]
    c.colors.downloads.stop.bg = palette["Base"]

    c.colors.downloads.error.fg = palette["Gold"]
    c.colors.downloads.start.fg = palette["Pine"]
    c.colors.downloads.stop.fg = palette["Rose"]
    c.colors.downloads.system.fg = "none"
    c.colors.downloads.system.bg = "none"

    c.colors.prompts.bg = palette["Surface"]
    c.colors.prompts.border = palette["Subtle"]
    c.colors.prompts.fg = palette["Text"]
    c.colors.prompts.selected.bg = palette["Overlay"]
    c.colors.prompts.selected.fg = palette["Text"]

    c.colors.messages.error.bg = palette["Surface"]
    c.colors.messages.error.border = palette["Surface"]
    c.colors.messages.error.fg = palette["Text"]

    c.colors.messages.info.bg = palette["Surface"]
    c.colors.messages.info.border = palette["Surface"]
    c.colors.messages.info.fg = palette["Gold"]

    c.colors.messages.warning.bg = palette["Surface"]
    c.colors.messages.warning.border = palette["Surface"]
    c.colors.messages.warning.fg = palette["Gold"]


# Setup
config.load_autoconfig(False)
colors_setup(c, palette)
