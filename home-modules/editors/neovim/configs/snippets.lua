local cmp = require('cmp')
local luasnip = require('luasnip')
local luasnip_loaders_from_vscode = require('luasnip.loaders.from_vscode')

-- Setup
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-j>'] = cmp.mapping.select_next_item(
      { behavior = cmp.SelectBehavior.Select }
    ),
    ['<C-k>'] = cmp.mapping.select_prev_item(
      { behavior = cmp.SelectBehavior.Select }
    ),
    ['<C-o>'] = cmp.mapping.confirm(
      { select = true }
    )
  }),
  sources = cmp.config.sources(
    { { name = 'nvim_lsp' }, { name = 'luasnip' } },
    { { name = 'buffer' } }
  )
})
luasnip_loaders_from_vscode.lazy_load()
