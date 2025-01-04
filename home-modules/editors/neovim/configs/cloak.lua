local cloak = require("cloak")

-- Setup
cloak.setup({
  enabled = true,
  cloak_character = "*",
  highlight_group = "Comment",
  patterns = {
    {
      file_pattern = '.passs',
      cloak_pattern = '.+',
      replace = nil,
    },
    {
      file_pattern = '.env*',
      cloak_pattern = '=.+',
      replace = nil,
    },
    {
      file_pattern = '.pypirc*',
      cloak_pattern = '=.+',
      replace = nil,
    }
  }
})
