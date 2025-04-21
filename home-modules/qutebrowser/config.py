from color_setup import setup
from theme import colors

# Make LSP stop complaining
config = config  # type: ignore
c = c # type: ignore

config.load_autoconfig(False)

# Colors
setup(c, colors)
