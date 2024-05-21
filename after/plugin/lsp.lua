local lsp = require('lsp-zero')
lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'H', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>d',"<cmd>Telescope diagnostics<cr>", opts) 
  vim.keymap.set('n', '<space>e',"<cmd>lua vim.diagnostic.open_float()<cr>", opts)
  end)

	lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['rust_analyzer'] = {'rust'},
		['gopls'] = {'go'},
		['templ'] ={'templ'}
  }
})
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'rust_analyzer', 'gopls', 'templ', 'tailwindcss'},
})

vim.filetype.add({ extension = { templ = "templ" } })

local lspconfig = require("lspconfig")

lspconfig.templ.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "templ" },
})

lspconfig.tailwindcss.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "templ", "astro", "javascript", "typescript", "react" },
    init_options = { userLanguages = { templ = "html" } },
})
lspconfig.htmx.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "templ",  "react" },
})
lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "lua" },
})
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'path'},
    {name = 'nvim_lua'},
    {name = 'buffer', keyword_length = 3},
  },
  formatting = lsp.cmp_format(),
  mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-j>'] = cmp.mapping(function()cmp.select_next_item() end),
      ['<C-k>'] = cmp.mapping(function()cmp.select_prev_item() end),
	  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
})
lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['gopls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['templ'].setup {
					cmd = {'templ', 'lsp'},
    capabilities = capabilities,
		filetypes = {"html", "templ"}
  }
  require('lspconfig')['tailwindcss'].setup {
    capabilities = capabilities,
		filetypes = {"html", "templ"}
  }
