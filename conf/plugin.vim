scriptencoding utf-8

" =============================================================
" {{{ NeoBundle のための設定

filetype off
set rtp+=~/.vim/bundle/neobundle.vim/
" 管理するフォルダを引数で渡します。
call neobundle#rc( '$HOME/.vim/bundle' )

let g:neobundle_default_git_protocol="git"

" NeoBundle が管理するプラグイン
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
	\ 'build' : {
		\     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
		\     'cygwin'  : 'make -f make_cygwin.mak',
		\     'mac'     : 'make -f make_mac.mak',
		\     'unix'    : 'make -f make_unix.mak',
		\    },
	\ }
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundleLazy 'vim-jp/cpp-vim', {
	\ 'autoload' : {'filetypes' : 'cpp'}
	\ }
NeoBundle 'tsaleh/vim-matchit'
NeoBundle 'kien/ctrlp.vim'
	NeoBundle 'the9ball/ctrlp-launcher'
	NeoBundle 'the9ball/ctrlp-verboselet'
NeoBundle 'vim-scripts/BufOnly.vim'
NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'kana/vim-submode'
NeoBundle 'thinca/vim-submode'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'the9ball/vim-projectdir'
NeoBundle 'the9ball/vim-auto-expandtab'
NeoBundle 'the9ball/vim-cycle', 'autoload'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'jceb/vim-hier'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'sjl/gundo.vim'
NeoBundleLazy 'osyo-manga/vim-textobj-blockwise'

if has('lua')
	NeoBundle 'Shougo/neocomplete.vim'
endif

" TODO これじゃ動かない？
"      とりあえず直接落としてきた。.
"NeoBundle 'jayed/pyclewn'

" textobject系
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'vim-scripts/surround.vim'
NeoBundle 'kana/vim-textobj-function'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-underscore'
NeoBundle 'thinca/vim-textobj-comment'

" 試用中
NeoBundle 'othree/eregex.vim'
NeoBundle 'tyru/coolgrep.vim'
NeoBundle 'mattn/vdbi-vim'

" 便利だけど、新タブで開かれるのがうざい。
" ので、あとで詳しく調べる。
"NeoBundle 'itchyny/thumbnail.vim'

" 動かし方を調べる。.
NeoBundle 'mattn/vim-metarw'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/vim-metarw-simplenote'
NeoBundle 'osyo-manga/vim-milfeulle'
NeoBundle 'Lokaltog/vim-easymotion'

" カラースキーム {{{
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/twilight'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/rdark'
NeoBundle 'vim-scripts/zazen'
colorscheme wombat
" }}}

" Win用
if g:is_win
NeoBundle 'thinca/vim-singleton'
"source $VIMRUNTIME/macros/editexisting.vim

endif

" 使ってみたいリスト {{{
" NeoBundle 'kana/vim-smartinput'
" NeoBundle 'mattn/excitetranslate-vim'
" NeoBundle 'deris/vim-rengbang'
" }}}

" 使わないことにしたリスト。{{{
" 別ファイルにすべきかも。

" Unite系
" 	NeoBundle 'sgur/unite-qf'
" 	NeoBundle 'Shougo/unite-build'

" rubyのバージョンが古かった・・・。
" NeoBundle 'astashov/vim-ruby-debugger'

" vim-easymotionがイマイチだったら使ってみる。
" NeoBundle 'kana/kuy-vim-fuzzyjump'

" vimが固まったし、有用性を感じなかった。
" NeoBundle 'tsukkee/unite-help'

" 使い方がわからなかった。
" NeoBundle 'daisuzu/unite-gtags'
" NeoBundle 'thinca/vim-unite-history'

" 使用しなくなった。
" NeoBundle 'motemen/git-vim'
" NeoBundle 'Shougo/vimshell'
" NeoBundle 'the9ball/ctrlp-gtags'

" つかいにくかった。
" NeoBundle 'rhysd/accelerated-jk'
" NeoBundle 'yuratomo/dbg.vim' pyclewnの方が使いやすい。
" NeoBundle 'cohama/vim-insert-linenr'

" 結局使わない。
" NeoBundle 'Lokaltog/vim-easymotion'
" NeoBundle 'vim-scripts/TwitVim'

" webの方が結局使いやすかった。
" NeoBundle 'tsukkee/lingr-vim'

" 起動時間もかかるし、使ってない。
" NeoBundle 'sgur/ctrlp-extensions.vim'
" NeoBundle 'Shougo/neosnippet'

" gtags使わなくなった。
" NeoBundle 'the9ball/gtags.vim'

" 検索に引っかからないことが多い？要調査
" NeoBundle 'fuenor/qfixgrep'

" }}}

" }}}
" =============================================================

" =============================================================
" {{{ プラグイン操作系

" tyruさんから
function! g:has_plugin(name)
    let nosuffix = a:name =~? '\.vim$' ? a:name[:-5] : a:name
    let suffix   = a:name =~? '\.vim$' ? a:name      : a:name . '.vim'
    return &rtp =~# '\c\<' . nosuffix . '\>'
    \   || globpath(&rtp, suffix, 1) != ''
    \   || globpath(&rtp, nosuffix, 1) != ''
    \   || globpath(&rtp, 'autoload/' . suffix, 1) != ''
    \   || globpath(&rtp, 'autoload/' . tolower(suffix), 1) != ''
endfunction

" }}}
" =============================================================

" =============================================================
" {{{ vim-singleton
" 真っ先に動かした方がいい気がする。.

if g:has_plugin( 'vim-singleton' )

let g:singleton#opener='drop'
call singleton#enable()

endif

" }}}
" =============================================================

" =============================================================
" {{{ neocomplete

if g:has_plugin( 'neocomplete' )

set completeopt+=longest

"起動時に有効
let g:neocomplete#enable_at_startup = 1
"ポップアップメニューで表示される候補の数。初期値は100
let g:neocomplete#max_list = 5
"自動補完を行う入力数を設定。初期値は2
let g:neocomplete#auto_completion_start_length = 2
"手動補完時に補完を行う入力数を制御。値を小さくすると文字の削除時に重くなる
let g:neocomplete#manual_completion_start_length = 3
"バッファや辞書ファイル中で、補完の対象となるキーワードの最小長さ。初期値は4。
let g:neocomplete#min_keyword_length = 4
"シンタックスファイル中で、補完の対象となるキーワードの最小長さ。初期値は4。
let g:neocomplete#min_syntax_length = 4
"1:補完候補検索時に大文字・小文字を無視する
let g:neocomplete#enable_ignore_case = 1
"入力に大文字が入力されている場合、大文字小文字の区別をする
let g:neocomplete#enable_smart_case = 1

"大文字小文字を区切りとしたあいまい検索を行うかどうか。
"DTと入力するとD*T*と解釈され、DateTime等にマッチする。
let g:neocomplete#enable_camel_case_completion = 1
"アンダーバーを区切りとしたあいまい検索を行うかどうか。
"m_sと入力するとm*_sと解釈され、mb_substr等にマッチする。
let g:neocomplete#enable_underbar_completion = 1
"ファジー補間
"g:neocomplete#enable_underbar_completion and
"g:neocomplete#enable_camel_case_completion is disabled.
let g:neocomplete#enable_fuzzy_completion = 1

if 1 " 以下を有効にするとシェルっぽい補間に。 {{{
	let g:neocomplete#enable_auto_select = 1
	let g:neocomplete#disable_auto_complete = 1
	inoremap <expr><C-n> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>"
endif " }}}

"シンタックス補完を無効に
let g:neocomplete#plugin_disable = {
\ 'syntax_complete' : 1, 
\ }

"補完するためのキーワードパターンを指定
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
"日本語を補完候補として取得しないようにする
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

"関数を補完するための区切り文字パターン
if !exists('g:neocomplete#delimiter_patterns')
	let g:neocomplete#delimiter_patterns = {}
endif
let g:neocomplete#delimiter_patterns['php'] = ['->', '::', '\']
let g:neocomplete#delimiter_patterns['cpp'] = ['\.', '->', '::']
let g:neocomplete#delimiter_patterns['cs']  = ['\.']
let g:neocomplete#delimiter_patterns['vim']  = ['#']

"カーソルより後のキーワードパターンを認識。
"h|geとなっている状態(|はカーソル)で、hogeを補完したときに後ろのキーワードを認識してho|geと補完する機能。
"修正するときにかなり便利。
" g:neocomplete#next_keyword_patternsは分からないときはいじらないほうが良いです。
"if !exists('g:neocomplete#next_keyword_patterns')
"	let g:neocomplete#next_keyword_patterns = {}
"endif
"
""ファイルタイプの関連付け
"if !exists('g:neocomplete#same_filetype_lists')
"	let g:neocomplete#same_filetype_lists = {}
"endif
"
""オムニ補完のパターンを設定
"if !exists('g:neocomplete#omni_patterns')
"	let g:neocomplete#omni_patterns = {}
"endif

" 先頭/終端へのジャンプ及び、補間キャンセル
inoremap <silent><expr> <C-a> pumvisible()? neocomplete#smart_close_popup() : "\<C-o>I"
inoremap <silent><expr> <C-e> pumvisible()? neocomplete#smart_close_popup() : "\<C-o>A"

" 改行で確定
inoremap <silent><expr> <CR> pumvisible()? neocomplete#smart_close_popup() : "\<CR>"

" 何故かcompletefuncが空になることがあるので・・・。
augroup neocomplete#completefunc
	autocmd!
	autocmd WinEnter,InsertEnter * set completefunc=neocomplete#complete#manual_complete
augroup END

endif


" }}}
" =============================================================

" =============================================================
" {{{ neosnippet

if g:has_plugin( 'neosnippet' )

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=i
endif

endif

" }}}
" =============================================================

" =============================================================
" {{{ quickrun

if g:has_plugin( 'quickrun' )

let g:quickrun_config = {
\    '_' : {
\       'runner' : 'vimproc',
\       'runner/vimproc/updatetime' : 60,
\       "outputter" : "quickfix",
\       "outputter/buffer/split" : ":botright 8sp",
\       "outputter/quickfix/open_cmd" : "copen",
\       "outputter/buffer/running_mark" : "ﾊﾞﾝ（∩`･ω･）ﾊﾞﾝﾊﾞﾝﾊﾞﾝﾊﾞﾝﾞﾝ",
\   },
\   'go' : {
\       'command' : 'go',
\       'exec': 'go run %s'
\   },
\   'phpunit' : {
\       'command' : 'phpunit',
\       'outputter' : 'buffer',
\       'outputter/buffer/split' : 'vertical 35',
\       'outputter/buffer/running_mark' : '',
\       'cmdopt' : '--no-configuration',
\       'exec': '%c %o %s'
\   },
\   'watchdogs_checker/_' : {
\       "hook/hier_update/enable_exit" : 1,
\       "hook/close_quickfix/enable_exit" : 1,
\   },
\   'phpunit/watchdogs_checker' : {
\       'type' : 'watchdogs_checker/php',
\   },
\}

" {{{ :QuickRun 時に quickfix の中身をクリアする
" こうしておかないと quickfix の中身が残ったままになってしまうため
let s:hook = {
\   "name" : "clear_quickfix",
\   "kind" : "hook",
\}

function! s:hook.on_normalized(session, context)
	call setqflist([])
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}

" =============================================================
" {{{ watchdogs

if g:has_plugin( 'vim-watchdogs' )

	call watchdogs#setup( g:quickrun_config )

	" 書き込み時のシンタックスチェック
	let g:watchdogs_check_BufWritePost_enable = 1

	if g:has_plugin( 'vim-hier' )
		execute "highlight watchdogs ctermbg=DarkGray gui=undercurl guisp=Red"
		let g:hier_highlight_group_qf = "watchdogs"

		augroup watchdogs-hier
			autocmd!
			autocmd TextChangedI * HierClear
		augroup END
	endif

endif

" }}}
" =============================================================
	
endif

" }}}
" =============================================================

" =============================================================
" {{{ CTRLP系

if g:has_plugin( 'CtrlP' )

let g:ctrlp_map='<Space>g'
"nnoremap <Space>c :<C-u>CtrlP<Space>
nnoremap <silent> <Space>e :<C-u>CtrlP %:p:h<CR>
nnoremap <silent> <Space>d :<C-u>CtrlP expand('<pwd>')<CR>
nnoremap <silent> <Space>s :<C-u>CtrlPLauncher<CR>
nnoremap <silent> <Space>m :<C-u>CtrlPMRUFiles<CR>
nnoremap <silent> <Space>l :<C-u>CtrlPLine<CR>
nnoremap <silent> <Space>v :<C-u>CtrlPVerboseLet<CR>
nnoremap <silent> <Space>y :<C-u>CtrlPYankring<CR>
nnoremap <silent> <Space>p :<C-u>call projectdir#init_ctrlp()<CR>

if !g:has_plugin( 'Thumbnail' )
nnoremap <silent> <Space>b :<C-u>CtrlPBuffer<CR>
endif

" nnoremap <silent> <Space>x :<C-u>CtrlPGtagsX<CR>
" nnoremap <silent> <Space>f :<C-u>CtrlPGtagsF<CR>
" nnoremap <silent> <Space>r :<C-u>CtrlPGtagsR<CR>

" キャッシュ？
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_by_filename = 1

" 既に開いていた場合
let g:ctrlp_switch_buffer = 0

" キーマッピング
let g:ctrlp_prompt_mappings = {
	\	'PrtCurLeft()'	:	['<left>', '<c-^>']
	\}

" ctrlp-launcherのファイル指定
let g:filename_ctrlp_launcher = $HOME.'/.vim/.ctrlp-launcher'

" 除外ファイル
let g:ctrlp_custom_ignore = {
\ 'dir'  : '\v\.(git|svn|hg)$',
\ 'file' : '\v\.(o|meta|dep|d)$',
\ }

endif

" }}}
" =============================================================

" =============================================================
" {{{ pyclewn

"if g:has_plugin( 'pyclewn' )

" パスを通す.
let $PATH=$HOME."/.vim/pyclewn/pyclewn-1.9.py2:".$PATH

source $HOME/.vim/pyclewn/pyclewn-1.9.py2/runtime/plugin/pyclewn.vim

" Pyclewn用キーバインド
nnoremap <silent> <F4> :<C-u>Pyclewn<CR>
"nnoremap <F6> :<C-u>call g:TogglePyclewnKeymap()<CR>
" キーマップのOn/OFF切り替え
let s:TogglePyclewnKeymapFlag = 0
function! g:TogglePyclewnKeymap()
	if  0 == s:TogglePyclewnKeymapFlag
		let s:TogglePyclewnKeymapFlag = 1
		echo "Cmapkeys enable"
		Cmapkeys
		nnoremap <S-p> :Cprint <C-r><C-w><CR>
	else
		let s:TogglePyclewnKeymapFlag = 0
		echo "Cmapkeys disable"
		Cunmapkeys
		nnoremap <S-p> <NOP>
	endif
endfunction
" ブレークポイント置く用。
function! g:PutBreak()
	let s:name = expand("%")
	let s:line = line(".")
	"echo ":Cbreak \"". s:name . "\":" .  s:line
	execute "Cbreak \\\"".s:name."\\\":".s:line
endfunction
" VCっぽく。
nnoremap <F5> :<C-u>Ccontinue<CR>
nnoremap <F9> :call g:PutBreak()<CR>
nnoremap <F10> :Cnext<CR>
nnoremap <F11> :Cstep<CR>
nnoremap <F12> :Cfinish<CR>

" ダブった時のことは知らない。
if 1
	function! g:AttachFunc( progname )
		let s:pid = system( "pgrep " . a:progname )
		"echo s:pid
		"echo exists( 'pyclewn#StartClewn' )
		if "" != s:pid
			"echo s:pid
			execute "Cattach".s:pid
		endif
	endfunction
	command! -bar -nargs=1 -complete=file Attach :call g:AttachFunc( <f-args> )
endif

"endif

" }}}
" =============================================================

" =============================================================
" {{{ gtags

if g:has_plugin( 'gtags' )

" gtags
nnoremap <C-g> :Gtags<Space>
" 次の候補
nnoremap <silent> <C-n> :cn<CR>
" 前の候補
nnoremap <silent> <C-p> :cp<CR>
" 現在のカーソルの個所にあるものの定義元を検索
" nnoremap <silent> <F11> :Gtags <C-r><C-w><CR>
" C+] の置きかえ
" 謎 exec "set runtimepath+=".escape(globpath(&runtimepath,'gtags'),' ')
nnoremap <silent> <C-]> :Gtags <C-r><C-w><CR>
" grep
" nnoremap <C-g><C-g> :Gtags -g <C-t><C-w><CR><CR><C-o>

endif

" }}}
" =============================================================

" =============================================================
" {{{ lingr-vim

if g:has_plugin( 'lingr-vim' )

let g:lingr_vim_user='Shaula'

endif

" }}}
" =============================================================

" =============================================================
" {{{ submode

if g:has_plugin( 'vim-submode' )

" 他のキーを押してleave_withした時に他のキーを有効にする。
" http://d.hatena.ne.jp/thinca/20130131/1359567419
let g:submode_leave_with_key = 1

" タイムアウトしない
let g:submode_timeout = 0

" Change GUI window size. {{{
call submode#enter_with( 'guiwinsize', 'n', '', '<C-w><Space>' )
call submode#leave_with( 'guiwinsize', 'n', '', '<Esc>' )
call submode#map       ( 'guiwinsize', 'n', '', 'j', '<C-w>+' )
call submode#map       ( 'guiwinsize', 'n', '', 'k', '<C-w>-' )
call submode#map       ( 'guiwinsize', 'n', '', 'h', '<C-w><' )
call submode#map       ( 'guiwinsize', 'n', '', 'l', '<C-w>>' )
" }}}

" 画面の左右スクロール {{{
" あとで何か考える。
call submode#enter_with( 'scroll', 'n', '', 'zl', 'zl' )
call submode#enter_with( 'scroll', 'n', '', 'zh', 'zh' )
call submode#leave_with( 'scroll', 'n', '', '<Esc>' )
call submode#map       ( 'scroll', 'n', '', 'l', 'zl' )
call submode#map       ( 'scroll', 'n', '', 'h', 'zh' )
" }}}

" 折り畳みの移動 {{{
call submode#enter_with( 'foldjump', 'n', '', 'zj', 'zj' )
call submode#enter_with( 'foldjump', 'n', '', 'zk', 'zk' )
call submode#enter_with( 'foldjump', 'n', '', 'zo', 'zo' )
call submode#enter_with( 'foldjump', 'n', '', 'zc', 'zc' )
call submode#leave_with( 'foldjump', 'n', '', '<Esc>' )
call submode#map       ( 'foldjump', 'n', '', 'j', 'zj' )
call submode#map       ( 'foldjump', 'n', '', 'k', 'zk' )
call submode#map       ( 'foldjump', 'n', '', 'o', 'zo' )
call submode#map       ( 'foldjump', 'n', '', 'O', 'zO' )
call submode#map       ( 'foldjump', 'n', '', 'c', 'zc' )
call submode#map       ( 'foldjump', 'n', '', 'C', 'zC' )
call submode#map       ( 'foldjump', 'n', '', 'm', 'zm' )
call submode#map       ( 'foldjump', 'n', '', 'M', 'zM' )
call submode#map       ( 'foldjump', 'n', '', 'v', 'zv' )
call submode#map       ( 'foldjump', 'n', '', 'zo', 'zo' )
call submode#map       ( 'foldjump', 'n', '', 'zc', 'zc' )
"}}}

endif

" }}}
" =============================================================

" =============================================================
" {{{ vim-indent-guides

if g:has_plugin( 'vim-indent-guides' )

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#121212 ctermbg=233
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#262626 ctermbg=235

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1

" hoge
	" fuga
	    " piyo
			" foo
	        	" bar

endif

" }}}
" =============================================================

" =============================================================
" {{{ EasyMotion

if g:has_plugin( 'EasyMotion' )

let g:EasyMotion_leader_key = '-'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_migemo = 1
let g:EasyMotion_startofline = 0

endif

" }}}
" =============================================================

" =============================================================
" {{{ vimprocでいろいろ

if g:has_plugin( 'vimproc' )

" =============================================================
" {{{ ctagsを自動作成

if executable( 'ctags' ) == 1
	augroup CTAGS
		autocmd!
		autocmd CursorHold,CursorHoldI,BufLeave * call vimproc#system_bg( 'ctags' )
	augroup END
endif

" }}}
" =============================================================

endif

" }}}
" =============================================================

" =============================================================
" {{{ その他1行系

if g:has_plugin( 'vim-projectdir' )
	let g:filename_projectdir_file = '$HOME/projectdir.conf'
endif

if g:has_plugin( 'eregex' )
	let g:eregex_default_enable = 0
endif

if g:has_plugin( 'vim-cycle' ) || g:has_plugin( 'vim-cycle_autoload' )
	let g:cycle_no_mappings=1 " 勝手にマッピングをしない.
	nnoremap <silent> <C-i> :<C-u>call cycle#CycleNext()<CR>
	call cycle#AddCycleGroup( ['hoge', 'fuga', 'piyo', 'hogera', 'hogehoge'] )
	call cycle#AddCycleGroup( ['foo', 'bar', 'baz', 'qux', 'quux', 'corge', 'grault', 'garply', 'waldo', 'fred', 'plugh', 'xyzzy', 'thud'] )
	call cycle#AddCycleGroup( ['On', 'Off'] )
	call cycle#AddCycleGroup( ['pick', 'fixup', 'reword', 'squash', 'edit', 'exec'] )
endif

if g:has_plugin( 'Thumbnail' )
	nnoremap <silent> <Space>b :<C-u>Thumbnail<CR>
endif

if g:has_plugin( 'vim-alignta' )
	vnoremap <silent> === :Align @1 =<CR>gv:Align @1 //<CR>
	vnoremap <silent> == :Align @1 =<CR>
	vnoremap <silent> =/ :Align @1 //<CR>
	vnoremap <silent> =m :Align <- m_<CR>
	vnoremap <silent> =M :Align <- m_<CR>
	vnoremap <silent> =<Space> :s/\v  +/ /ge<CR>:nohlsearch<CR>gv:Align @0 \ <CR>
endif

if g:has_plugin( 'qfixgrep' )
	" qfixgrep独自のquickfix制御は無効にする
	let g:disable_QFixWin = 1
	" qfixgrep用のキーマップを使用しない
	let g:MyGrep_Keymap = 0

	" 簡単vimgrep
	nnoremap s :<C-u>RGrep -E "\<<C-r><C-w>\>" *
	" カーソル下の単語をソースから検索
	nnoremap sfs :<C-u>RGrep -E "\<<C-r><C-w>\>" *.c*<CR>
	" カーソル下の単語をヘッダから検索
	nnoremap sfh :<C-u>RGrep -E "\<<C-r><C-w>\>" *.h*<CR>
endif

if g:has_plugin( 'vim-anzu' )
	nmap <silent> n <plug>(anzu-n)zzzv
	nmap <silent> N <plug>(anzu-N)zzzv
	" nmap <silent> * <plug>(anzu-star)<plug>(anzu-N)
	" nmap <silent> # <plug>(anzu-sharp)<plug>(anzu-n)
endif

if g:has_plugin( 'gundo.vim' )
	nnoremap U :<C-u>GundoToggle<CR>
endif

" }}}
" =============================================================

" =============================================================
" {{{ 使わなくなった設定達
" いつの日か使うかもしれないもの。

" =============================================================
" {{{ unite系

if g:has_plugin( 'unite' )

"nnoremap <silent> <Space>b :<C-u>Unite -auto-resize -hide-source-names buffer<CR>
"nnoremap <silent> <Space>f :<C-u>UniteWithBufferDir -auto-resize -hide-source-names file<CR>
"nnoremap <silent> <Space>/ :<C-u>Unite -buffer-name=search line -auto-resize -start-insert -no-quit<CR>
"nnoremap <silent> <Space>r :<C-u>Unite -auto-resize -hide-source-names file_mru<CR>

command! -bar -nargs=0 Colorscheme :Unite colorscheme -auto-preview

"call unite#filters#default#use( [ 'converter_relative_word', 'matcher_default', 'sorter_word', 'converter_relative_abbr' ] )

" buffer を開いた時に常に絶対パスで表示させたい。
"call unite#custom_filters( 'buffer', [ 'converter_relative_word', 'matcher_default', 'sorter_word', 'converter_relative_abbr' ] )

" Unite qf 系用
" 調整中
"command! -bar -nargs=1 UniteQfHelper :call g:fUniteQfHelper( <args> )
"function! g:fUniteQfHelper( ope )
"	" スペースをエスケープする。
"	let s:temp = substitute( a:ope, ' ', '\\ ', 'g' )
"
"	" 実行
"	execute "Unite qf:ex=" . s:temp
"endfunction
"
"" vimgrep を Unite で。
"" 調整中
""手入力の方がよさそう nnoremap <Space>v :<C-u>Vim<Space>
"command! -bar -nargs=+ Vim :call g:fVim( <f-args> )
"command! -bar -nargs=+ VIm :call g:fVim( <f-args> )
"command! -bar -nargs=+ VIM :call g:fVim( <f-args> )
"function! g:fVim( pattern, files )
"	let s:temp = 'vimgrep ' . a:pattern . ' ' . a:files
"	". "--no-empty"
"	call g:fUniteQfHelper( s:temp )
"	cclose
"endfunction

endif

" }}}
" =============================================================

" =============================================================
" {{{ TwitVim

if g:has_plugin( 'TwitVim' )

let twitvim_login_b64 = "dGhlOWJhbGw=:am1rdW05a2o="
let twitvim_count = 2000

endif

" }}}
" =============================================================

" }}}
" =============================================================

" =============================================================
" {{{ 

"if g:has_plugin( '' )

"endif

" }}}
" =============================================================
