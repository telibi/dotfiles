set number
set title
set showmatch
set scrolloff=3 "余裕を持たせてスクロール"

"文字コード
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac

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
"if &term =~ "xterm"
"	let &t_SI .= "\e[?2004h"
"	let &t_EI .= "\e[?20041"
"	let &pastetoggle = "\e[201~"

"	function XTermPasteBegin(ret)
"		set paste
"		return a:ret
"	endfunction

"	inoremap <special> <eqpr> <Esc>[200~XTermPasteBegin("")
"endif

" short cut--------------------------------------------
inoremap <silent> jj <ESC>
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>
nnoremap Y y$
nnoremap + <C-a>
nnoremap - <C-x>
set pastetoggle=<F3>

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
nnoremap <F6> :VimFiler
nnoremap <F4> :SyntasticToggleMode

"quickrun
nnoremap <Leader>q :<C-u>bw! \[quickrun\ output\]<CR>

"noesnnippet------------------------------------------------
"neocomplcache------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
	\ 'default' : ''
	\ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
"------------------
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
 
 " SuperTab like snippets behavior.
 imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)"
 \: pumvisible() ? "\<C-n>" : "\<TAB>"
 smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)"
 \: "\<TAB>"
  
	" For snippet_complete marker.
	if has('conceal')
		set conceallevel=2 concealcursor=i
	endif



 "検索結果の件数を表示
 nmap n <Plug>(anzu-n-with-echo)
 nmap N <Plug>(anzu-N-with-echo)
 nmap * <Plug>(anzu-star-with-echo)
 nmap # <Plug>(anzu-sharp-with-echo)
 nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
 set statusline=%{anzu#search_status()}
