--------------------------------------------------------------------------------
--
-- Neovim editor options
--   For a full list of available options use :help option-list
--
--------------------------------------------------------------------------------

vim.opt.number         = true
vim.opt.relativenumber = true

-- Enable mouse support in all modes
vim.opt.mouse = 'a'

-- Ignore the case in searches
vim.opt.ignorecase = true
-- ... except we use an uppercase letter in the search
vim.opt.smartcase  = true
vim.opt.hlsearch   = false

-- I like spaces over tabs and want to have 2 spaces by default
vim.opt.tabstop    = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab  = true

