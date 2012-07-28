" =============================================================
" {{{ Vundle のための設定

filetype off
set rtp+=~/.vim/bundle/vundle/
" 管理するフォルダを引数で渡します。
call vundle#rc( '$HOME/.vim/bundle' )

" Vundle が管理するプラグイン
Bundle 'vim-jp/vimdoc-ja'
Bundle 'gmarik/vundle'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'jayed/pyclewn'
Bundle 'the9ball/gtags.vim'
Bundle 'vim-scripts/surround.vim'
Bundle 'tsaleh/vim-matchit'

" 試用中
Bundle 'motemen/git-vim'
Bundle 'sgur/unite-qf'
Bundle 'vim-scripts/TwitVim'
Bundle 'othree/eregex.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Shougo/unite-build'

" 使わないことにしたリスト。{{{
" 別ファイルにすべきかも。

" シンタックスチェッカーだが、誤検出が多い印象
" Bundle 'scrooloose/syntastic'

" rubyのバージョンが古かった・・・。
" Bundle 'astashov/vim-ruby-debugger'

" vim-easymotionがイマイチだったら使ってみる。
" Bundle 'kana/kuy-vim-fuzzyjump'

" なんかエラーだって。調べるのが面倒なので放置。
" Bundle 'tsukkee/lingr-vim'

" vimが固まったし、有用性を感じなかった。
" Bundle 'tsukkee/unite-help'

" 使い方がわからなかった。
" Bundle 'daisuzu/unite-gtags'
" Bundle 'thinca/vim-unite-history'

" }}}

" }}}
" =============================================================

" =============================================================
" {{{ unite系

nnoremap <silent> <Space>b :<C-u>Unite -auto-resize -hide-source-names buffer<CR>
nnoremap <silent> <Space>f :<C-u>UniteWithBufferDir -auto-resize -hide-source-names file<CR>
nnoremap <silent> <Space>/ :<C-u>Unite -buffer-name=search line -auto-resize -start-insert -no-quit<CR>
nnoremap <silent> <Space>r :<C-u>Unite -auto-resize -hide-source-names file_mru<CR>

call unite#filters#default#use( [ 'matcher_default', 'sorter_word', 'converter_default' ] )

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

" }}}
" =============================================================

" =============================================================
" {{{ pyclewn

" 一旦読み込み
source <sfile>:h/pyclewn.vim
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

" }}}
" =============================================================

" =============================================================
" {{{ gtags

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

" }}}
" =============================================================

" =============================================================
" {{{ syntastic

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

" }}}
" =============================================================

" =============================================================
" {{{ TwitVim

let twitvim_login_b64 = "dGhlOWJhbGw=:am1rdW05a2o="
let twitvim_count = 2000

" }}}
" =============================================================

" =============================================================
" {{{ EasyMotion

let g:EasyMotion_leader_key	=	','

" }}}
" =============================================================

" =============================================================
" {{{ lingr-vim

"まだテスト中
"g:lingr_vim_user=the9ball@gmail.com

" }}}
" =============================================================

" =============================================================
" {{{ gitdiff???

" いつ入れたか覚えていない・・・なんの設定？
command! -bar -nargs=* GitDiffEol GitDiff --ignore-space-at-eol --ignore-space-change <args>

" }}}
" =============================================================

