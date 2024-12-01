return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      local autopairs = require('nvim-autopairs')
      local Rule = require('nvim-autopairs.rule')
      local cond = require('nvim-autopairs.conds')

      autopairs.setup({
        -- General settings
        disable_filetype = { "TelescopePrompt", "vim" },
        disable_in_macro = false,
        disable_in_visualblock = false,
        enable_moveright = true,
        enable_afterquote = true,
        enable_check_bracket_line = true,
        
        -- Treesitter integration
        check_ts = true,
        ts_config = {
          lua = {'string'},
          javascript = {'template_string'},
          java = false,
        },

        -- Bracket and quote pairing
        fast_wrap = {
          map = '<M-e>',  -- Alt+e to fast wrap
          chars = { '{', '[', '(', '"', "'" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
          highlight = 'Search',
          highlight_grey = 'Comment'
        },

        -- Specific rules for different scenarios
        map_cr = true,
        map_bs = true,  -- map backspace
        map_c_h = false,  -- Map <C-h> to delete pairs
      })

      -- HTML and XML specific auto-close tags
      autopairs.add_rules({
        -- Auto-close HTML tags
        Rule("<", ">", {"html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte"})
          :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return pair ~= "<"
          end)
          :with_move(cond.done())
          :use_key(">")
          :replace_endpair(function(opts)
            local prev_line = opts.line:sub(1, opts.col - 1)
            local next_char = opts.line:sub(opts.col, opts.col)
            
            -- Check if it's a self-closing tag or a complete tag
            if next_char ~= ">" then
              return "</" .. prev_line:match("<(%w+)") .. ">"
            end
            return ""
          end),
      })

      -- Special pairs for different languages
      autopairs.add_rules({
        -- Add space inside pairs
        Rule(" ", " ")
          :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({ "()", "[]", "{}" }, pair)
          end),
        
        -- Auto-add closing bracket for function definitions
        Rule("(", ")")
          :use_key(")")
          :with_pair(cond.not_before_text("[")),
      })

      -- Integration with completion (optional)
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
    dependencies = {
      'hrsh7th/nvim-cmp',  -- Optional: for completion integration
    }
  }
}