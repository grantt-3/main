return { {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
    vim.g.barbar_auto_setup = false
    -- Keymaps for buffer navigation and management
    vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>',
      { noremap = true, silent = true, desc = 'Previous buffer' })
    vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })
    vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>',
      { noremap = true, silent = true, desc = 'Close current buffer' })
    vim.keymap.set('n', '<A-s-c>', '<Cmd>BufferCloseAllButCurrent<CR>',
      { noremap = true, silent = true, desc = 'Close all buffers except current' })
  end,
  opts = {
    -- Animation settings
    animation = true,

    -- Buffer placement
    insert_at_start = false,
    insert_at_end = false,

    -- Sidebar configuration
    sidebar_filetypes = {
      NvimTree = true,
      undotree = { text = 'Undotree', align = 'center' },
      ['neo-tree'] = { event = 'BufWipeout' },
      Outline = {
        event = 'BufWinLeave',
        text = 'Symbols Outline',
        align = 'right'
      },
    },

    -- Icon configuration
    icons = {
      buffer_index = true, -- Show buffer index in the tabline
      buffer_number = false,
      button = 'x',        -- Close button
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'Γ£ÿ' },
        [vim.diagnostic.severity.WARN] = { enabled = true, icon = 'ΓÜá' },
        [vim.diagnostic.severity.INFO] = { enabled = true, icon = 'Γä╣' },
        [vim.diagnostic.severity.HINT] = { enabled = true, icon = '≡ƒÆí' },
      },
      filetype = {
        enabled = true,       -- Enable file type icons
        custom_colors = true, -- Use custom colors for file type icons
      },
      separator = {
        left = '|',
        right = '',
      },
      inactive = {
        button = '', -- No close button for inactive buffers
      },
    },

    -- Maximum padding
    maximum_padding = 1,
    minimum_padding = 1,
    maximum_length = 30, -- Maximum buffer name length

    -- Semantic highlighting
    semantic_letters = true,
    no_name_title = '[No Name]',
  },
  version = '^1.0.0',
}, }
