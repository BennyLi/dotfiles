-- All custom keyboard mappings.
-- Try to group them by context.

local keymap_opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap


-- Remap space as leader key
keymap('', '<Space>', '<Nop>', keymap_opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal Mode
keymap('n', '<leader>e', ':Lex 30<cr>', keymap_opts)

--   Better window navigation
keymap('n', '<C-h>', '<C-w>h', keymap_opts)
keymap('n', '<C-j>', '<C-w>j', keymap_opts)
keymap('n', '<C-k>', '<C-w>k', keymap_opts)
keymap('n', '<C-l>', '<C-w>l', keymap_opts)

--   Resize with arrows
keymap('n', '<C-Up>', ':resize +2<CR>', keymap_opts)
keymap('n', '<C-Down>', ':resize -2<CR>', keymap_opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', keymap_opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', keymap_opts)

--   Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', keymap_opts)
keymap('n', '<S-h>', ':bprevious<CR>', keymap_opts)


-- Insert
--   Press jk fast to enter
keymap('i', 'jk', '<ESC>', keymap_opts)


-- Visual
--   Stay in indent mode
keymap('v', '<', '<gv', keymap_opts)
keymap('v', '>', '>gv', keymap_opts)

--   Move text up and down
keymap('v', '<A-j>', ':m .+1<CR>==', keymap_opts)
keymap('v', '<A-k>', ':m .-2<CR>==', keymap_opts)


-- Visual Block
--   Move text up and down
keymap('x', 'J', ":move '>+1<CR>gv-gv", keymap_opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", keymap_opts)
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", keymap_opts)
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", keymap_opts)


-- Terminal
--   Better terminal navigation
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)
