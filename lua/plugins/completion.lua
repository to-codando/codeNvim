-- ~/.config/nvim/lua/plugins/completion.lua
return {
  {
    'ckolkey/ts-node-action',
    requires = { 'nvim-treesitter' },
    config = function()
      require("ts-node-action").setup({})
    end
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require('nvim-ts-autotag').setup({})
    end,
  },
  {
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true, -- Integrar com treesitter para identificar pares
      })

      -- Integrando nvim-autopairs com nvim-cmp
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",         -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer",           -- Buffer completions
      "hrsh7th/cmp-path",             -- Path completions
      "hrsh7th/cmp-cmdline",          -- Command line completions
      "saadparwaiz1/cmp_luasnip",     -- Snippet completions
      "L3MON4D3/LuaSnip",             -- Snippet engine
      "rafamadriz/friendly-snippets", -- Collection of snippets
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      require('luasnip/loaders/from_vscode').lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'luasnip' },
        },
      })
    end,
  },
  {
    "saadparwaiz1/cmp_luasnip",
    after = "nvim-cmp",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    after = "nvim-cmp",
  },
  {
    "hrsh7th/cmp-buffer",
    after = "nvim-cmp",
  },
  {
    "hrsh7th/cmp-path",
    after = "nvim-cmp",
  },
  {
    "hrsh7th/cmp-cmdline",
    after = "nvim-cmp",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  {
    "rafamadriz/friendly-snippets",
  },
}

