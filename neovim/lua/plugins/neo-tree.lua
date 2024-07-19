return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    },
    config = function()
      --------------------------------------------------------------------------------
      --
      -- Keybindings
      --
      --------------------------------------------------------------------------------
      local wk = require('which-key')
      wk.register({
        t = {
          name = 'tree',
          t = { '<cmd>Neotree<cr>', 'Toggle Neotree sidebar' },
        },
      }, { prefix = '<leader>' })
    end
}
