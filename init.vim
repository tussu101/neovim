:set nocompatible
:filetype off

call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'http://github.cm/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/tc50cal/vim-terminal'
Plug 'https://github.com/preservim/tagbar'
Plug 'https://github.com/terryma/vim-multiple-cursors'
" Plug 'jiangmiao/auto-pairs'
Plug 'sirver/ultisnips'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'glepnir/dashboard-nvim'
Plug 'puremourning/vimspector'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

set encoding=UTF-8
call plug#end()

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nmap <F8> :TagbarToggle<CR>

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

filetype plugin indent on
syntax on
highlight ColorColumn ctermbg=0 guibg=lightgrey
set t_Co=256
set number relativenumber
set nu rnu
set nowrap
set smartcase
set hlsearch
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent
set mouse=a
set splitbelow
set splitright
set smarttab
set clipboard=unnamedplus
set guicursor=
set hidden
set nowrap
set wrap
set linebreak

:imap jj <Esc>

let mapleader = " "
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>

noremap <Leader>q :q
noremap <Leader>Q :q!
noremap <Leader>w :w
noremap <Leader>x :wq
noremap <Leader>t :TerminalSplit bash
noremap <Leader>v :vertical
noremap <Leader>n :tabnew
noremap <Leader>c :tabc
noremap <Leader>f :FZF

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let airline#extensions#tmuxline#snapshot_file = "~/.config/tmux/tmux-status.conf"
let g:tmuxline_preset = {
        \ 'a': '[#S]',
        \ 'win': '#I:#W#F',
        \ 'cwin': '#I:#W#F',
        \ 'x': '#{prefix_highlight}',
        \ 'y': '%H:%M',
        \ 'z': '%d-%b-%y',
        \ 'options': {
        \ 'status-justify': 'left'}
        \ }
