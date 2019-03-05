" General settings {{{1
nnoremap <SPACE> <Nop>
let mapleader=' '

set number
set nocompatible
filetype plugin on
syntax on

" Folding {{{2
set foldenable
set foldmethod=marker
nnoremap <leader><space> za

" Plugin configuration {{{1
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'pearofducks/ansible-vim'
Plug 'chr4/nginx.vim'

Plug 'airblade/vim-gitgutter'

Plug 'vimwiki/vimwiki'
Plug 'tbabej/taskwiki'

call plug#end()

" Plugin config for: lightline {{{2
set laststatus=2

" Plugin config for: vimwiki {{{2
let wiki_1 = {}
let wiki_1.path = '~/Documents/nc-familie/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let g:vimwiki_list = [wiki_1]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

let g:taskwiki_markup_syntax = 'markdown'

" Plugin config for: CtrlP {{{2
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>
