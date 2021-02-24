set t_Co=256 " enable 256 colour mode
set tabstop=2 " set tab size to 2
set shiftwidth=2 " tab size to 2 for autoindent
set noexpandtab " use tabs instead of spaces
set autoindent " enable autoindent
set colorcolumn=80 " show ruler at column 80
set encoding=utf-8 " always open with encoding utf-8
set endofline " always add a blank line to the end of file
set number " show line numbers
set cursorline " highlight the current line
set completeopt=menuone,longest " always show the autocomplete dialog
set shortmess+=c " hide completion messages
set splitbelow " always split a pane to the bottom
set splitright " always split a pane to the right
set nowrap " disable word wrap
set hidden " TextEdit might fail if not set
set nobackup " don't keep the backup file
set nowritebackup " don't create a backup file
set noundofile " avoid creating *.un~ files
set showtabline=2 " always show buffer tabs
set noshowmode " hide the mode messages
set updatetime=300 " reduce the update time

autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType gitcommit setlocal colorcolumn=50
autocmd FileType markdown setlocal wrap

" Try to merge numbers column with errors column.
if has('patch-8.1.1564')
	set signcolumn=number
else
	set signcolumn=yes
endif

" Automatically install vim-plug if not installed.
if empty(glob('~/.vim/autoload/plug.vim'))
	execute 'silent !curl -fLo' $HOME . '/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim' " onedark theme
Plug 'preservim/nerdtree' " files explorer
Plug 'Xuyuanp/nerdtree-git-plugin' " git status flags on explorer
Plug 'ryanoasis/vim-devicons' " icons on explorer
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " colours in explorer icons
Plug 'preservim/tagbar' " code outline
Plug 'vim-airline/vim-airline' " enhance the bottom bar
Plug 'neoclide/coc.nvim', {'branch': 'release'} " language server
Plug 'mattn/emmet-vim' " emmet support
Plug 'editorconfig/editorconfig-vim' " check for .editorconfig files
Plug 'https://tpope.io/vim/fugitive.git' " git hints for airline
Plug 'sheerun/vim-polyglot' " multiple language support
Plug 'vim-scripts/dbext.vim' " SQL support
Plug 'nicwest/vim-http' " use as REST client
Plug 'ap/vim-css-color'	" preview colours
Plug 'airblade/vim-accent' " support for accents
call plug#end()

if (empty($TMUX))
	if (has("nvim"))
		let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
	endif
	if (has("termguicolors"))
		set termguicolors
	endif
endif

let mapleader = ' '
nnoremap <silent> <F12> :source $MYVIMRC<CR>
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
nnoremap <silent> <leader>tn :tabedit<CR>
nnoremap <silent> <leader>sh :sp<CR>
nnoremap <silent> <leader>sv :vsp<CR>
nnoremap <leader>fi gg=G''
nnoremap <silent> <leader>ot :terminal<CR>
nmap <leader>gh :diffget //2<CR>
nmap <leader>gl :diffget //3<CR>
nmap <leader>gs :G<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gk :Gpush<CR>
nmap <leader>gj :Gpull<CR>
nmap <F8> :TagbarToggle<CR>
nnoremap <leader>d "_d
xnoremap <leader>d "_d

inoremap <silent> <C-@> <C-x><C-o>
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-@> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
	\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <leader>rn <Plug>(coc-rename)
imap <C-l> <Plug>(coc-snippets-expand)
nnoremap <leader>ff :CocCommand prettier.formatFile<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

function! s:show_documentation()
	if (index(['vim', 'help'], &filetype) >= 0)
		execute 'h'.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

syntax on
filetype plugin indent on
colorscheme onedark

" Try to use IBeam cursor.
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[6 q"
let &t_EI = "\<Esc>[6 q"

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extension#tabline#show_buffers = 0
let g:airline_theme = 'onedark'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:user_emmet_settings = {'javascript': {'extends': 'jsx'}}

hi! CocErrorSign guifg=#d1666a
hi! CocWarningSign guifg=#e5c07b
hi! CocInfoSign guifg=#e5c07b

let g:vim_http_split_vertically = 1
let g:vim_http_tempbuffer = 1

let g:NERDTreeDirArrowExpandable = '→'
let g:NERDTreeDirArrowCollapsible = '↓'
let NERDTreeIgnore = ['__init__.py', '__pycache__']

" Start NERDTree at startup (only if no files were specified)
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
