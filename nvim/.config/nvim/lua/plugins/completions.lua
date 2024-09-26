return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
          "rafamadriz/friendly-snippets",
        },
        build = "make install_jsregexp"
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require('luasnip')
      require("luasnip.loaders.from_vscode").lazy_load()

      local cmp_kinds = {
        Text = '  ',
        Method = '  ',
        Function = '  ',
        Constructor = '  ',
        Field = '  ',
        Variable = '  ',
        Class = '  ',
        Interface = '  ',
        Module = '  ',
        Property = '  ',
        Unit = '  ',
        Value = '  ',
        Enum = '  ',
        Keyword = '  ',
        Snippet = '  ',
        Color = '  ',
        File = '  ',
        Reference = '  ',
        Folder = '  ',
        EnumMember = '  ',
        Constant = '  ',
        Struct = '  ',
        Event = '  ',
        Operator = '  ',
        TypeParameter = '  ',
      }

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },

        formatting = {
          fields = { "abbr", "kind" },
          format = function(_, vim_item)
            vim_item.kind = " " and cmp_kinds[vim_item.kind] or ""
            return vim_item
          end,
        },

        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<A-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp", max_item_length = 5 },
          { name = "luasnip",  max_item_length = 5 },
          { name = "buffer",   max_item_length = 3 },
          { name = 'path',     max_item_length = 3 }
        }),

        performance = {
          max_view_entries = 10
        },
      })
    end,
  },
}
