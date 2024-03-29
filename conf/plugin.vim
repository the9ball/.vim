scriptencoding utf-8

" =============================================================
" {{{ プラグイン操作系

" tyruさんから
function! HasPlugin(name)
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
" {{{ NeoBundle のための設定

filetype off
set rtp+=~/.vim/bundle/neobundle.vim/
" 管理するフォルダを引数で渡します。
call neobundle#begin( '$HOME/.vim/bundle' )

let g:neobundle_default_git_protocol="git"

NeoBundle 'thinca/vim-singleton'
" =============================================================
" {{{ vim-singleton
" 真っ先に動かした方がいい気がする。.

if HasPlugin( 'vim-singleton' )

let g:singleton#opener='drop'
call singleton#enable()

endif

" }}}
" =============================================================


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
NeoBundle 'tmhedberg/matchit'
NeoBundle 'kien/ctrlp.vim'
	NeoBundle 'the9ball/ctrlp-launcher'
	NeoBundle 'the9ball/ctrlp-verboselet'
NeoBundle 'vim-scripts/BufOnly.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kana/vim-submode'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'the9ball/vim-projectdir'
NeoBundle 'the9ball/vim-auto-expandtab'
NeoBundle 'the9ball/vim-cycle', 'autoload'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'thinca/vim-quickrun'
	NeoBundle 'osyo-manga/shabadou.vim'
	NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'jceb/vim-hier'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'osyo-manga/vim-brightest'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'Lokaltog/vim-easymotion'

if has('lua')
	NeoBundle 'Shougo/neocomplete.vim'
	NeoBundle 'osyo-manga/vim-marching'
endif

NeoBundleLazy 'nosami/Omnisharp', {
\   'autoload': {'filetypes': ['cs']},
\   'build': {
\     'windows': 'MSBuild.exe server/OmniSharp.sln /p:Platform="Any CPU"',
\     'mac': 'xbuild server/OmniSharp.sln',
\     'unix': 'xbuild server/OmniSharp.sln',
\   }
\ }

" textobject系
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'vim-scripts/surround.vim'
NeoBundle 'kana/vim-textobj-function'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-underscore'
NeoBundle 'thinca/vim-textobj-comment'
NeoBundle 'anyakichi/vim-textobj-ifdef'
NeoBundle 'osyo-manga/vim-textobj-blockwise'

" git系
NeoBundleLazy 'tpope/vim-fugitive'
NeoBundleLazy 'cohama/agit.vim'

" 遊び系
NeoBundleLazy 'thinca/vim-threes'

" 試用中
NeoBundle 'tyru/capture.vim'
NeoBundle 'fatih/vim-go'
NeoBundle "aklt/plantuml-syntax"
NeoBundle 'vim-scripts/ShaderHighLight'

" 便利だけど、新タブで開かれるのがうざい。
" ので、あとで詳しく調べる。
"NeoBundle 'itchyny/thumbnail.vim'

" 動かし方を調べる。.

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
colorscheme desert
" }}}

" 使ってみたいリスト {{{
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
" NeoBundle 'osyo-manga/vim-milfeulle'

" 使用しなくなった。
" NeoBundle 'motemen/git-vim'
" NeoBundle 'Shougo/vimshell'
" NeoBundle 'the9ball/ctrlp-gtags'

" つかいにくかった。
" NeoBundle 'rhysd/accelerated-jk'
" NeoBundle 'cohama/vim-insert-linenr'

" 結局使わない。
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

" ビルドが必要だし、そもそもC++を書かなくなった。
" NeoBundle 'jeaye/color_coded'
" NeoBundleLazy 'jeaye/color_coded', {
" 		\ 'build': {
" 		\   'unix': 'cmake . && make && make install',
" 		\ },
" 		\ 'autoload' : { 'filetypes' : ['c', 'cpp', 'objc', 'objcpp'] },
" 		\ 'build_commands' : ['cmake', 'make']
" 	\}

" 勝手にカッコが出てくるとうざい
" NeoBundle 'kana/vim-smartinput'

" 必要性を感じなくなった
" NeoBundle 'mattn/excitetranslate-vim'
" NeoBundle 'deris/vim-rengbang'
" NeoBundle 'mattn/webapi-vim'
" NeoBundle 'mattn/vim-metarw'

" }}}

call neobundle#end()

" }}}
" =============================================================

" =============================================================
" {{{ neocomplete

if HasPlugin( 'neocomplete' )

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#max_list = 100
let g:neocomplete#max_keyword_width = 40
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#manual_completion_start_length = 1
let g:neocomplete#min_keyword_length = 3
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#force_overwrite_completefunc = 1 " 0でもいいかも
let g:neocomplete#use_vimproc = 0 " 1でもいいかも
let g:neocomplete#data_directory = "~/neocomplete"

nnoremap <Leader>ne :<C-u>NeoCompleteEnable<CR>
nnoremap <Leader>nd :<C-u>NeoCompleteDisable<CR>
nnoremap <Leader>nt :<C-u>NeoCompleteToggle<CR>

endif


" }}}
" =============================================================

" =============================================================
" {{{ marching

if HasPlugin( 'marching' )

" 非同期ではなくて同期処理で補完する
let g:marching_backend = "sync_clang_command"

" オプションの設定
" これは clang のコマンドに渡される
let g:marching_clang_command_option="-std=c++1y"


" neocomplete.vim と併用して使用する場合
" neocomplete.vim を使用すれば自動補完になる
let g:marching_enable_neocomplete = 1

if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.cpp =
	\ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

endif

" }}}
" =============================================================

" =============================================================
" {{{ neosnippet

if HasPlugin( 'neosnippet' )

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

if HasPlugin( 'quickrun' )

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

if HasPlugin( 'vim-watchdogs' )

	call watchdogs#setup( g:quickrun_config )

	" 書き込み時のシンタックスチェック
	let g:watchdogs_check_BufWritePost_enable = 1

	if HasPlugin( 'vim-hier' )
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

if HasPlugin( 'CtrlP' )

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

if !HasPlugin( 'Thumbnail' )
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
" {{{ gtags

if HasPlugin( 'gtags' )

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

if HasPlugin( 'lingr-vim' )

let g:lingr_vim_user='Shaula'

endif

" }}}
" =============================================================

" =============================================================
" {{{ submode

if HasPlugin( 'vim-submode' )

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

endif

" }}}
" =============================================================

" =============================================================
" {{{ vim-indent-guides

if HasPlugin( 'vim-indent-guides' )

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

if HasPlugin( 'EasyMotion' )

let g:EasyMotion_leader_key = '-'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_migemo = 1
let g:EasyMotion_startofline = 0

silent! nmap <unique> s <Plug>(easymotion-s)

endif

" }}}
" =============================================================

" =============================================================
" {{{ vimprocでいろいろ

if HasPlugin( 'vimproc' )

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

if HasPlugin( 'vim-projectdir' )
	let g:filename_projectdir_file = '$HOME/projectdir.conf'
endif

if HasPlugin( 'eregex' )
	let g:eregex_default_enable = 0
endif

if HasPlugin( 'vim-cycle' ) || HasPlugin( 'vim-cycle_autoload' )
	let g:cycle_no_mappings=1 " 勝手にマッピングをしない.
	nnoremap <silent> <C-i> :<C-u>call cycle#CycleNext()<CR>
	call cycle#AddCycleGroup( ['hoge', 'fuga', 'piyo', 'hogera', 'hogehoge'] )
	call cycle#AddCycleGroup( ['foo', 'bar', 'baz', 'qux', 'quux', 'corge', 'grault', 'garply', 'waldo', 'fred', 'plugh', 'xyzzy', 'thud'] )
	call cycle#AddCycleGroup( ['On', 'Off'] )
	call cycle#AddCycleGroup( ['pick', 'fixup', 'reword', 'squash', 'edit', 'exec'] )
	call cycle#AddCycleGroup( ['１', '２', '３', '４', '５', '６', '７', '８', '９', '０'] )
endif

if HasPlugin( 'Thumbnail' )
	nnoremap <silent> <Space>b :<C-u>Thumbnail<CR>
endif

if HasPlugin( 'vim-alignta' )
	vnoremap <silent> === :Align @1 =<CR>gv:Align @1 //<CR>
	vnoremap <silent> == :Align @1 =<CR>
	vnoremap <silent> =/ :Align @1 //<CR>
	vnoremap <silent> =m :Align <- m_<CR>
	vnoremap <silent> =M :Align <- m_<CR>
	vnoremap <silent> =<Space> :s/\v  +/ /ge<CR>:nohlsearch<CR>gv:Align @0 \ <CR>
endif

if HasPlugin( 'qfixgrep' )
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

if HasPlugin( 'vim-anzu' )
	nmap <silent> n <plug>(anzu-n)zzzv
	nmap <silent> N <plug>(anzu-N)zzzv
	" nmap <silent> * <plug>(anzu-star)<plug>(anzu-N)
	" nmap <silent> # <plug>(anzu-sharp)<plug>(anzu-n)
endif

if HasPlugin( 'gundo.vim' )
	nnoremap <space>u :<C-u>GundoToggle<CR>
endif

if HasPlugin( 'fugitive' )
	nnoremap gp :<C-u>Ggrep -nH<space>
endif

if HasPlugin( 'vim-go' )
	let g:go_fmt_command = "goimports"
endif

if HasPlugin( 'vim-markdown' )
	au BufRead,BufNewFile *.md set filetype=markdown
endif

" }}}
" =============================================================

" =============================================================
" {{{ 使わなくなった設定達
" いつの日か使うかもしれないもの。

" =============================================================
" {{{ unite系

if HasPlugin( 'unite' )

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

if HasPlugin( 'TwitVim' )

let twitvim_login_b64 = "dGhlOWJhbGw=:am1rdW05a2o="
let twitvim_count = 2000

endif

" }}}
" =============================================================

" }}}
" =============================================================

" =============================================================
" {{{

"if HasPlugin( '' )

"endif

" }}}
" =============================================================
