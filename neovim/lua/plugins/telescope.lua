--------------------------------------------------------------------------------
--
-- Telescope
--
--------------------------------------------------------------------------------

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim'
    },
    config = function()
      --------------------------------------------------------------------------------
      --
      -- Register Extensions
      --
      --------------------------------------------------------------------------------
      local telescope = require('telescope')
      telescope.load_extension('fzf')
      --------------------------------------------------------------------------------
      --
      -- Keybindings
      --
      --------------------------------------------------------------------------------
      local wk = require('which-key')
      wk.register({
        f = {
          name = 'find',
          f = { '<cmd>Telescope find_files<cr>', 'Find files' },
          g = { '<cmd>Telescope live_grep<cr>', 'Grep in all files in current worksapce' },
          b = { '<cmd>Telescope buffers<cr>', 'Quickly switch buffers' },
          h = { '<cmd>Telescope help_tags<cr>', 'Search all help files' },
        },
      }, { prefix = '<leader>' })
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
  }
}
