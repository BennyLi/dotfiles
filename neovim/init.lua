--------------------------------------------------------------------------------
--
-- This is Ben's Neovim config
--
-- Good sources about lua Neovim configs:
--   - https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/
--   - https://github.com/nanotee/nvim-lua-guide
--
-- TODO
--   - https://github.com/tpope/vim-fugitive
--------------------------------------------------------------------------------

-- Neovim editor options
require('config.editor')


-- Keybindings, NOT belonging to plugins
require('config.keybindings')


-- Plugins
require('config.lazy')

