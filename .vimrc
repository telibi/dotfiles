set number
set title
set showmatch

" tab--------------------------------------------------
set tabstop=2
set softtabstop=2
set shiftwidth=2
"smartindent-------------------------------------------
set smartindent
set shiftwidth=2

" search-----------------------------------------------
set ignorecase
set smartcase
set wrapscan
set hlsearch

set clipboard=unnamed,autoselect

set cursorline

"from cripboard to paste------------------------------
if &term =~ "xterm"
	let &t_SI .= "\e[?2004h"
	let &t_EI .= "\e[?20041"
	let &pastetoggle = "\e[201~"

	function XTermPasteBegin(ret)
		set paste
		return a:ret
	endfunction

	inoremap <special> <eqpr> <Esc>[200~XTermPasteBegin("")
endif

" short cut--------------------------------------------
inoremap <silent> jj <ESC>

"dein.vim-----------------------------------------------
if &compatible
	set nocompatible
endif

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')

"(中略)

call dein#end()



" vimrcに以下のように追記

"プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
"dein.vim本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

"dein.vimがなければgithubから落としてくる
if &runtimepath !~# '/dein.vim'
	if !isdirectory(s:dein_repo_dir)
		execute "!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
	endif
	execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

"設定開始
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	"プラグインリストを収めた TOML ファイル
	"予め TOML ファイル(後述)を用意しておく
	let g:rc_dir     = expand('~/.vim/rc')
	let s:toml       = g:rc_dir . '/dein.toml'
	let s:lazy_toml  = g:rc_dir . '/dein_lazy.toml'


	" TOML を読み込み、キャッシュしておく
	call dein#load_toml(s:toml,      {'lazy': 0})
	call dein#load_toml(s:lazy_toml, {'lazy': 1})

	"設定終了
	call dein#end()
	call dein#save_state()
endif

"もし、未インストールがあったらインストール
if dein#check_install()
	call dein#install()
endif

"dein.vim_end-------------------------------------------


"molokai------------------------------------------------
colorscheme molokai
syntax on
set t_Co=256
set background=dark

let g:indentLine_setColors = 0
let g:indentLine_color_term = 239
let g:indentLine_color_tty_light = 7
let g:indentLine_color_dark = 1
let g:indentLine_bgcolor_term = 202
let g:indentLine_bgcolor_gui = '#FF5F00'
let g:indentLine_char = '|'

"syntastic-----------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastice_check_on_wq = 0

let g:syntastic_C_checkers = ['gcc']

"vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1

"VimFiler
let g:vimfiler_as_default_explorer = 1
let g:vimliler_enable_auto_cd = 1
nnoremap <F10> :VimFiler

"quickrun
nnoremap <Leader>q :<C-u>bw! \[quickrun\ output\]<CR>
