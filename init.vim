" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'tpope/vim-surround'
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
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'vimwiki/vimwiki'
Plug 'airblade/vim-gitgutter'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'dense-analysis/ale'
Plug 'fisadev/vim-isort'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'filipekiss/ncm2-look.vim'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'
Plug 'AndrewRadev/tagalong.vim'

set encoding=UTF-8
call plug#end()


" General Setting
:set nocompatible
:filetype off
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
set updatetime=1000 "set update time for gitgutter update

:imap jj <Esc>

let mapleader = " "
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>

noremap <Leader>q :q
noremap <Leader>Q :q!
noremap <Leader>w :w
noremap <Leader>x :wq
noremap <Leader>t :TerminalSplit bash
noremap <Leader>v :vertical res15
noremap <Leader>n :tabnew 
noremap <Leader>c :tabc
noremap <Leader>f :FZF
noremap <Leader>o :tabo
noremap <Leader>r :res6


" Nerdtree
nnoremap <leader>N :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nmap <F8> :TagbarToggle<CR>

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"


" Vim air-line
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


" Vimwiki
let g:vimwiki_list = [{'path': '~/documents/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]


" Prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0


" Gitgutter
let g:gitgutter_async = 0


" Ale Linting
let g:ale_lint_on_enter=1
let g:ale_echo_msg_error_str='E'
let g:ale_echo_msg_warning_str='W'
let g:ale_echo_msg_format='[%linter%] %s [%severity%]: [%...code...%]'
let g:ale_linters={'python' : ['flake8'], 'r': ['linter']}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0


" vim-isort
let g:vim_isort_map = '<C-i>'


" markdown-preview.nvim
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
let g:mkdp_filetypes = ['markdown']
let g:mkdp_theme = 'dark'


" ncm2-look
let g:ncm2_look_enabled = 1


" emmet
let g:user_emmet_leader_key=','
