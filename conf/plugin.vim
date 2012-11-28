" =============================================================
" {{{ NeoBundle のための設定

filetype off
set rtp+=~/.vim/bundle/neobundle.vim/
" 管理するフォルダを引数で渡します。
call neobundle#rc( '$HOME/.vim/bundle' )

" Vundle が管理するプラグイン
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'vim-jp/cpp-vim'
NeoBundle 'tsaleh/vim-matchit'
NeoBundle 'kien/ctrlp.vim'
	NeoBundle 'sgur/ctrlp-extensions.vim'
	NeoBundle 'the9ball/ctrlp-launcher'
	NeoBundle 'the9ball/ctrlp-gtags'
	NeoBundle 'the9ball/ctrlp-verboselet'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'the9ball/gtags.vim'
NeoBundle 'vim-scripts/surround.vim'
NeoBundle 'vim-scripts/BufOnly.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kana/vim-submode'

" TODO これじゃ動かない？
"      とりあえず直接落としてきた。.
"NeoBundle 'jayed/pyclewn'

" 試用中
NeoBundle 'othree/eregex.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/neosnippet'

" 使ってみたいリスト {{{
" NeoBundle 'kana/vim-smartinput'
" }}}

" 使わないことにしたリスト。{{{
" 別ファイルにすべきかも。

" Unite系
" NeoBundle 'Shougo/unite.vim'
" 	NeoBundle 'sgur/unite-qf'
" 	NeoBundle 'Shougo/unite-build'

" シンタックスチェッカーだが、誤検出が多い印象
" NeoBundle 'scrooloose/syntastic'

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

" つかいにくかった。
" NeoBundle 'rhysd/accelerated-jk'

" 結局使わない。
" NeoBundle 'Lokaltog/vim-easymotion'
" NeoBundle 'vim-scripts/TwitVim'

" webの方が結局使いやすかった。
" NeoBundle 'tsukkee/lingr-vim'

" }}}

" }}}
" =============================================================

" =============================================================
" {{{ プラグイン操作系

" tyruさんから
function! s:has_plugin(name)
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
" {{{ Neocomplcache

if s:has_plugin( 'neocomplcache' )

" とりあえずコピペ。
" http://www.karakaram.com/neocomplcache

"起動時に有効
let g:neocomplcache_enable_at_startup = 1
"ポップアップメニューで表示される候補の数。初期値は100
let g:neocomplcache_max_list = 5
"自動補完を行う入力数を設定。初期値は2
let g:neocomplcache_auto_completion_start_length = 2
"手動補完時に補完を行う入力数を制御。値を小さくすると文字の削除時に重くなる
let g:neocomplcache_manual_completion_start_length = 3
"バッファや辞書ファイル中で、補完の対象となるキーワードの最小長さ。初期値は4。
let g:neocomplcache_min_keyword_length = 4
"シンタックスファイル中で、補完の対象となるキーワードの最小長さ。初期値は4。
let g:neocomplcache_min_syntax_length = 4
"1:補完候補検索時に大文字・小文字を無視する
let g:neocomplcache_enable_ignore_case = 1
"入力に大文字が入力されている場合、大文字小文字の区別をする
let g:neocomplcache_enable_smart_case = 1
"大文字小文字を区切りとしたあいまい検索を行うかどうか。
"DTと入力するとD*T*と解釈され、DateTime等にマッチする。
let g:neocomplcache_enable_camel_case_completion = 1
"アンダーバーを区切りとしたあいまい検索を行うかどうか。
"m_sと入力するとm*_sと解釈され、mb_substr等にマッチする。
let g:neocomplcache_enable_underbar_completion = 0


" TODO:エラー出まくっていたのであとで調べる.
	"キャッシュディレクトリの場所
	"RamDiskをキャッシュディレクトリに設定
	" if has('win32')
		" let g:neocomplcache_temporary_dir = 'E:/.neocon'
	" elseif has('macunix')
		" let g:neocomplcache_temporary_dir = '/Volumes/RamDisk/.neocon'
	" else
		" let g:neocomplcache_temporary_dir = '/tmp/.neocon'
	" endif

"シンタックス補完を無効に
let g:neocomplcache_plugin_disable = {
\ 'syntax_complete' : 1, 
\ }

"補完するためのキーワードパターンを指定
if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
"日本語を補完候補として取得しないようにする
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"twigはhtmlと同じに
let g:neocomplcache_keyword_patterns['twig'] = '</\?\%([[:alnum:]_:-]\+\s*\)\?\%(/\?>\)\?\|&amp;\h\%(\w*;\)\?\|\h[[:alnum:]_-]*="\%([^"]*"\?\)\?\|\h[[:alnum:]_:-]*'

"関数を補完するための区切り文字パターン
if !exists('g:neocomplcache_delimiter_patterns')
	let g:neocomplcache_delimiter_patterns = {}
endif
let g:neocomplcache_delimiter_patterns['php'] = ['->', '::', '\']

"カーソルより後のキーワードパターンを認識。
"h|geとなっている状態(|はカーソル)で、hogeを補完したときに後ろのキーワードを認識してho|geと補完する機能。
"修正するときにかなり便利。
" g:neocomplcache_next_keyword_patternsは分からないときはいじらないほうが良いです。
if !exists('g:neocomplcache_next_keyword_patterns')
	let g:neocomplcache_next_keyword_patterns = {}
endif
"よく分からない場合は未設定のほうがよいとのことなので、ひとまずコメントアウト
"let g:neocomplcache_next_keyword_patterns['php'] =
"'\h\w*>'
"twigはhtmlと同じに
let g:neocomplcache_next_keyword_patterns['twig'] = '[[:alnum:]_:-]*>\|[^"]*"'


"ファイルタイプの関連付け
if !exists('g:neocomplcache_same_filetype_lists')
	let g:neocomplcache_same_filetype_lists = {}
endif
"let g:neocomplcache_same_filetype_lists['ctp'] = 'php'
"let g:neocomplcache_same_filetype_lists['twig'] =
"'html'


"ディクショナリ補完
"ファイルタイプごとの辞書ファイルの場所
let g:neocomplcache_dictionary_filetype_lists = {
\ 'default' : '',
\ 'php' : $HOME . '/.vim/dict/php.dict',
\ 'ctp' : $HOME . '/.vim/dict/php.dict',
\ 'twig' : $HOME . '/.vim/dict/twig.dict',
\ 'vimshell' : $HOME . '/.vimshell/command-history',
\ }

"タグ補完
"タグファイルの場所
augroup SetTagsFile
	autocmd!
	autocmd FileType php set tags=$HOME/.vim/tags/php.tags
augroup END
"タグ補完の呼び出しパターン
if !exists('g:neocomplcache_member_prefix_patterns')
	let g:neocomplcache_member_prefix_patterns = {}
endif
let g:neocomplcache_member_prefix_patterns['php'] = '->\|::'

"スニペット補完
"標準で用意されているスニペットを無効にする。初期化前に設定する
let g:neocomplcache_snippets_disable_runtime_snippets = 0
"スニペットファイルの置き場所
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'

"zencoding連携
let g:use_zen_complete_tag = 1

"オムニ補完
augroup SetOmniCompletionSetting
	autocmd!
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType ctp setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType twig setlocal omnifunc=htmlcomplete#CompleteTags
	"  autocmd FileType
	"  php setlocal
	"  omnifunc=phpcomplete#CompletePHP
augroup END

"オムニ補完のパターンを設定
if !exists('g:neocomplcache_omni_patterns')
	let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns['twig']= '<[^>]*'
"let
"g:neocomplcache_omni_patterns['php']
"= '[^.
"\t]->\h\w*\|\h\w*::'

" Enterで改行
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
" Tabで一番目の候補を選択
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

endif


" }}}
" =============================================================

" =============================================================
" {{{ neosnippet

if s:has_plugin( 'neosnippet' )

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
" {{{ CTRLP系

if s:has_plugin( 'CtrlP' )

let g:ctrlp_map='<Space>p'
"nnoremap <Space>c :<C-u>CtrlP<Space>
nnoremap <silent> <Space>e :<C-u>CtrlP %:p:h<CR>
nnoremap <silent> <Space>d :<C-u>CtrlP expand('<pwd>')<CR>
nnoremap <silent> <Space>b :<C-u>CtrlPBuffer<CR>
nnoremap <silent> <Space>s :<C-u>CtrlPLauncher<CR>
nnoremap <silent> <Space>m :<C-u>CtrlPMRUFiles<CR>
nnoremap <silent> <Space>l :<C-u>CtrlPLine<CR>
nnoremap <silent> <Space>v :<C-u>CtrlPVerboseLet<CR>
nnoremap <silent> <Space>x :<C-u>CtrlPGtagsX<CR>
nnoremap <silent> <Space>f :<C-u>CtrlPGtagsF<CR>
nnoremap <silent> <Space>r :<C-u>CtrlPGtagsR<CR>
nnoremap <silent> <Space>y :<C-u>CtrlPYankring<CR>

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

"if s:has_plugin( 'pyclewn' )

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

if s:has_plugin( 'gtags' )

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
" {{{ syntastic

if s:has_plugin( 'syntastic' )

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

endif

" }}}
" =============================================================

" =============================================================
" {{{ lingr-vim

if s:has_plugin( 'lingr-vim' )

let g:lingr_vim_user='Shaula'

endif

" }}}
" =============================================================

" =============================================================
" {{{ submode

if s:has_plugin( 'vim-submode' )

" Change GUI window size.
call submode#enter_with('guiwinsize', 'n', '', '<S-w>', '<Nop>')
call submode#leave_with('guiwinsize', 'n', '', '<Esc>')
call submode#map       ('guiwinsize', 'n', '', 'j', '<C-w>+')
call submode#map       ('guiwinsize', 'n', '', 'k', '<C-w>-')
call submode#map       ('guiwinsize', 'n', '', 'h', '<C-w><')
call submode#map       ('guiwinsize', 'n', '', 'l', '<C-w>>')

" 画面の左右スクロール
" あとで何か考える。
call submode#enter_with( 'scroll', 'n', '', 'zl', '<Nop>' )
call submode#leave_with( 'scroll', 'n', '', '<Esc>' )
call submode#map       ( 'scroll', 'n', '', 'l', 'zl')
call submode#map       ( 'scroll', 'n', '', 'h', 'zh')

endif

" }}}
" =============================================================

" =============================================================
" {{{ その他1行系

" }}}
" =============================================================

" =============================================================
" {{{ 使わなくなった設定達
" いつの日か使うかもしれないもの。

" =============================================================
" {{{ unite系

if s:has_plugin( 'unite' )

"nnoremap <silent> <Space>b :<C-u>Unite -auto-resize -hide-source-names buffer<CR>
"nnoremap <silent> <Space>f :<C-u>UniteWithBufferDir -auto-resize -hide-source-names file<CR>
"nnoremap <silent> <Space>/ :<C-u>Unite -buffer-name=search line -auto-resize -start-insert -no-quit<CR>
"nnoremap <silent> <Space>r :<C-u>Unite -auto-resize -hide-source-names file_mru<CR>

call unite#filters#default#use( [ 'converter_relative_word', 'matcher_default', 'sorter_word', 'converter_relative_abbr' ] )

" buffer を開いた時に常に絶対パスで表示させたい。
call unite#custom_filters( 'buffer', [ 'converter_relative_word', 'matcher_default', 'sorter_word', 'converter_relative_abbr' ] )

" Unite qf 系用
" 調整中
command! -bar -nargs=1 UniteQfHelper :call g:fUniteQfHelper( <args> )
function! g:fUniteQfHelper( ope )
	" スペースをエスケープする。
	let s:temp = substitute( a:ope, ' ', '\\ ', 'g' )

	" 実行
	execute "Unite qf:ex=" . s:temp
endfunction

" vimgrep を Unite で。
" 調整中
"手入力の方がよさそう nnoremap <Space>v :<C-u>Vim<Space>
command! -bar -nargs=+ Vim :call g:fVim( <f-args> )
command! -bar -nargs=+ VIm :call g:fVim( <f-args> )
command! -bar -nargs=+ VIM :call g:fVim( <f-args> )
function! g:fVim( pattern, files )
	let s:temp = 'vimgrep ' . a:pattern . ' ' . a:files
	". "--no-empty"
	call g:fUniteQfHelper( s:temp )
	cclose
endfunction

endif

" }}}
" =============================================================

" =============================================================
" {{{ EasyMotion

if s:has_plugin( 'EasyMotion' )

let g:EasyMotion_leader_key	=	','

endif

" }}}
" =============================================================

" =============================================================
" {{{ TwitVim

if s:has_plugin( 'TwitVim' )

let twitvim_login_b64 = "dGhlOWJhbGw=:am1rdW05a2o="
let twitvim_count = 2000

endif

" }}}
" =============================================================

" }}}
" =============================================================
