import theme

# Make LSP stop complaining
config = config  # type: ignore
c = c # type: ignore

config.load_autoconfig(False)

# Colors
theme.setup(c)
