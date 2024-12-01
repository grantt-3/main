  return { {
      'boganworld/crackboard.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('crackboard').setup({
          session_key = 'f2cd778595204a576a99b7c5a25ab207831a7b6f123f2157544380aeebb78aa0',
        })
      end,
    },
}