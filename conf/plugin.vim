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
NeoBundle 'jayed/pyclewn'
NeoBundle 'the9ball/gtags.vim'
NeoBundle 'vim-scripts/surround.vim'
NeoBundle 'tsukkee/lingr-vim'

" 試用中
NeoBundle 'othree/eregex.vim'
NeoBundle 'kana/vim-submode'
NeoBundle 'motemen/git-vim'

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
" NeoBundle 'Shougo/vimshell'

" つかいにくかった。
" NeoBundle 'rhysd/accelerated-jk'

" 結局使わない。
" NeoBundle 'Lokaltog/vim-easymotion'
" NeoBundle 'vim-scripts/TwitVim'

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
" {{{ CTRLP系

if s:has_plugin( 'CtrlP' )

let g:ctrlp_map='<Space>p'
"nnoremap <Space>c :<C-u>CtrlP 
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

if s:has_plugin( 'pyclewn' )

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

endif

" }}}
" =============================================================

" =============================================================
" {{{ gtags

if s:has_plugin( 'gtags' )

" gtags
nnoremap <C-g> :Gtags 
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
" {{{ git-vim???

if s:has_plugin( 'git-vim' )

" いつ入れたか覚えていない・・・なんの設定？
command! -bar -nargs=* GitDiffEol GitDiff --ignore-space-at-eol --ignore-space-change <args>

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
"手入力の方がよさそう nnoremap <Space>v :<C-u>Vim 
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
