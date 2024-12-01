return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = function()
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    local hooks = require "ibl.hooks"
    -- Create highlights for rainbow indent lines
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    require("ibl").setup {
      -- Global configuration
      enabled = true,
      debounce = 200,

      -- Indent line appearance
      indent = {
        char = "│", -- Single-width vertical line
        highlight = highlight,
        smart_indent_cap = true,
      },

      -- Whitespace configuration
      whitespace = {
        remove_blankline_trail = true,
      },

      -- Scope highlighting
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
        injected_languages = true,
        highlight = highlight,
        priority = 500,
      },

      -- Exclude filetypes
      exclude = {
        filetypes = {
          "help",
          "terminal",
          "dashboard",
          "packer",
          "lspinfo",
          "TelescopePrompt",
          "TelescopeResults",
          "mason",
          "lazy",
          "neo-tree",
        },
      },
    }

    -- Additional keymaps for toggling indent guides
    vim.keymap.set('n', '<leader>ti', function()
      local current_state = require('ibl.config').get_config().enabled
      if current_state then
        vim.cmd('IBLDisable')
        print("Indent guides disabled")
      else
        vim.cmd('IBLEnable')
        print("Indent guides enabled")
      end
    end, { noremap = true, silent = true, desc = "Toggle indent guides" })
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
}

