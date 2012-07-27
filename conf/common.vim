" =============================================================
" {{{ 基本設定

" カレント .vimrc, .exrc などを読まない
set noexrc

" 背景色を指定することで文字色を設定
set background=dark
" set background=light
colorscheme elflord

" マウス有効化
set mouse=nch
set ttymouse=xterm2
set nu
set clipboard+=autoselect

" 改行コードの自動認識
set fileformats=unix,dos,mac

" 長い行を折り返しなしに
set nowrap

" 無名レジスタに入るデータを*レジスタにも入れる。
set clipboard+=unnamed

" ファイル名補完をシェルと同じように。
set wildmode=list:longest

" 検索結果のハイライト
set hlsearch

" 構文フォントカラー
syntax enable

" 検索時の大文字小文字を区別しない
set ignorecase
" set wildignorecase
" 検索する文字に大文字が1つでも入っていた場合は、大文字小文字を区別する。
set smartcase
" 検索が最後の時に最初へ戻らないように
set nowrapscan

" ステータスバーを常時表示
set laststatus=2
" 右下に情報を出す。
set ruler

" 上下最低5行を残してスクロール
set scrolloff=5
" 左右最低10文字を残してスクロール
set sidescrolloff=10

" 全角文字に色を付ける
" highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#555555
" au BufNewFile,BufRead * match ZenkakuSpace /　//

" vimgrep コマンドの結果を quickfix に出力
" au QuickfixCmdPost vimgrep cw
" 各種Quickfixを処理する際に、結果がある時だけウィンドウを開く。
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep if len(getqflist()) != 0 | copen | endif

" omni補完ON?
filetype plugin on
" omni補完用のtag
" set tags+=""

" ファイルを開くときに変更破棄しない。
set hidden

" ウィンドウ分割時の挙動
" 横分割したら新しいウィンドウは下に
set splitbelow
" 縦分割したら新しいウィンドウは右に
set splitright

" タブ文字、改行文字を表示
"set list	やっぱ見にくかった。
" 改行、タブ文字の設定
set listchars=tab:^\ ,trail:-
"tab:タブ:	
"trail:行末のスペース: 

" vimdiff
set diffopt=filler,iwhite

" オプションのトグル
command! -nargs=1 Tgl call s:toggle_option( '<args>' )
function! s:toggle_option(option_name)
	execute 'setlocal' a:option_name.'!'
	execute 'setlocal' a:option_name.'?'
endfunction

" }}}
" =============================================================

" =============================================================
" {{{ ファイルを開いた時にfiletypeなどによって設定を変更する。
" au FileType でやった方が見やすいのか・・・？

function! s:BufAdd()
	" switchってないんだっけ？

	" =============================================================
	" {{{ vim script 入力

	if 'vim' == &filetype || 'VIM' == &filetype
		" vimscript再読み込み
		nnoremap <buffer> <C-e> :w<CR>:source %<CR>

		" コメントアウト
		vnoremap <buffer> <silent> / :s/^\(\s*\)/\1\"/g<CR>gv:s/^\(\s*\)\"\"/\1/g<CR>:nohlsearch<CR>
	endif

	" }}}
	" =============================================================

	" =============================================================
	" {{{ ReadOnly用

	if &readonly && 0
		" ものぐさ。undoとかできないから不都合あるかも。
		" b でのワード移動が使えないのが地味に痛かった。
		nnoremap <buffer> u <C-u>
		nnoremap <buffer> d <C-d>
		nnoremap <buffer> f <C-f>
		nnoremap <buffer> b <C-b>
	endif

	" }}}
	" =============================================================

endfunction
augroup MyFileOpen
	au!
	au BufNewFile,BufRead,FileReadPost,FilterReadPost,StdinReadPost * call s:BufAdd()
augroup END

" }}}
" =============================================================

" =============================================================
" {{{ 記述支援

" タブ
set tabstop=4
set softtabstop=4
" オートインデント時のタブ量
set shiftwidth=4

" オートインデント
set autoindent
" C言語形式のインデント
set cindent

" インデント指定
" {{{
	" 一旦初期化
	set cinoptions=
	" case のインデント位置
	set cinoptions+=:0
	" case の {} の位置
	set cinoptions+=l-1s
	" class の アクセス識別子(publicとか)の位置
	set cinoptions+=g0
	" 複数行コメントの位置
	set cinoptions+=c1

	" 一番やりたいのに・・・。
	" 閉じていない括弧の位置
	set cinoptions+=(1s
	" 閉じていない括弧の中の位置
	set cinoptions+=u1s
	" ( や u の指定を無視しない???
	set cinoptions+=U1
	" ) の位置を ( のある行の行頭に合わせる。
	set cinoptions+=m1

	" 基底クラスの宣言とかの位置???
	" set cinoptions+=i0
	" 戻り値の指定???
	" set cinoptions+=t0
" }}}

" <BS>で文字が消えない問題の対応
set backspace=indent,eol,start

" 改行時にコメントしない
" なぜか効かない。
set formatoptions-=ro

" }}}
" =============================================================

" =============================================================
" {{{ 入力をやめた際にIMEをOFFし、再開時にもとに戻す。

if	1
	" screen/tmuxによってうまく動かないとのこと。
	" 挿入モードに入った際のシーケンス
	" let &t_SI .= "\e[<r"
	" 挿入モードから出た際のシーケンス
	" let &t_EI .= "\e[<s\e[<0t"
	" vim終了時のシーケンス
	" let &t_te .= "\e[<0t\e[<s"

	if $term =~ "screen" || $TERM =~ "screen"
		" screen の場合は \eP と \e\\ で囲めば問題ない。
		" 挿入モードに入った際のシーケンス
		let &t_SI .= "\eP\e[<r\e\\"
		" 挿入モードから出た際のシーケンス
		let &t_EI .= "\eP\e[<s\e[<0t\e\\"
		" vim終了時のシーケンス
		let &t_te .= "\eP\e[<0t\e[<s\e\\"
	else
		" screen 以外
		" 挿入モードに入った際のシーケンス
		let &t_SI .= "\e[<r"
		" 挿入モードから出た際のシーケンス
		let &t_EI .= "\e[<s\e[<0t"
		" vim終了時のシーケンス
		let &t_te .= "\e[<0t\e[<s"
	endif
	" IMEを切り替える時間
	" 時間が短いと変更が間に合わない可能性があるとのこと。
	set timeoutlen=200
endif

inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" }}}
" =============================================================

" =============================================================
" {{{ 折り畳み設定

" foldmethod(fdm)	:	折り畳みの形式
"							marker	マーカー ( {{{ / }}} )
"							indent	インデント
"							syntax	構文	結構見づらい
"							expr	自分で指定
" foldmarker(fmr)	:	マーカーの指定

" expr 用定義 """"""""""""""""""""""""""""""""""""

" 設定 """""""""""""""""""""""""""""""""""""""""""

" 基本はマーカー ( {{{ や }}} ) で折り畳み
set fdm=marker

augroup FoldMethodAutocmd
	au! *
	autocmd FileType *
	\	if &l:omnifunc == ''
	\	|	setlocal omnifunc=syntaxcomplete#Complete
	\	|endif

	" 素直に設定すると、コメントアウトされている括弧にも反応してしまう。
	if 1
		autocmd FileType c,cpp,h,hpp,php
		\	setlocal fmr={,}
	else
		" TODO がんばる
		" この辺が参考になるかも。
		" https://github.com/thinca/vim-ft-vim_fold
		" http://d.hatena.ne.jp/thinca/20110516/1305471815
		" http://d.hatena.ne.jp/thinca/20110523/1306080318
		" http://d.hatena.ne.jp/tyru/20110517/disable_modeline_and_use_foldexpr
		autocmd FileType c,cpp,h,hpp,php
		\	set fdm=expr
		\|	set foldexpr=getline(v:lnum)=~'//[^{]*{'
	endif

	autocmd FileType xml,as,mxml
	\	setlocal fdm=syntax
augroup END

" }}}
" =============================================================

" =============================================================
" {{{ 予約語の補完

autocmd FileType *
\	if &l:omnifunc == ''
\	|	setlocal omnifunc=syntaxcomplete#Complete
\	|endif

" }}}
" =============================================================

" =============================================================
" {{{ ウィンドウ移動時の処理

augroup MyWinEnter
	au!

	" テスト用コード
	"au WinEnter * if getwinvar(0,'&buftype') != 'quickfix' | echo "test" | endif

	" カレントウィンドウのサイズを調整
	" あまり大きく指定すると逆に操作しづらい結果になるので注意。
	" 横幅を調整 端数の4は行番号の分
	" quickfix は除く。
	au WinEnter * if getwinvar(0, '&buftype') != 'quickfix' | if winwidth(0) < 104 | vertical resize 104 | endif | endif
	" 縦幅を調整
	au WinEnter * if getwinvar(0, '&buftype') != 'quickfix' | if winheight(0) < 30 | resize 30 | endif | endif

	" 罫線
	" '_' が見えにくいため、一定時間で罫線を無くす。
	au WinLeave * set nocursorcolumn nocursorline
	au CursorMoved,CursorMoved * set cursorline
	au CursorHold,CursorHoldI,InsertEnter * set nocursorline nocursorcolumn

	" 試行錯誤途中？
	" au WinEnter,BufRead * set cursorcolumn cursorline
	" au WinEnter,BufRead * set cursorline

	" 検索ハイライト
	" au CursorMoved,CursorMovedI * set nocursorcolumn
	" au CursorHold,CursorHoldI * normal *	" 自分で * をタイプするので必要ない
	" au CursorHold,CursorHoldI * set cursorcolumn
augroup END

" ラインを表示したうえで反転表示
"set cursorline
"highlight cursorline term=reverse cterm=reverse

" }}}
" =============================================================

" =============================================================
" {{{ ステータス

set statusline=							" 一旦クリア
set statusline+=[%n]					" バッファ番号
set statusline+=[%Y]					" ファイル形式
set statusline+=:%t						" ファイル名
set statusline+=%m						" 修正フラグ
set statusline+=%r						" 読み込み専用フラグ
set statusline+=%w						" プレビューウィンドウフラグ
set statusline+=%=						" 左と右の境界
set statusline+=%{b:visual_charcnt()}\ 	" ヴィジュアルモード時に選択している文字の数
set statusline+=%l,%v					" カーソル位置
set statusline+=\ %p%%					" ファイル内のページの位置
set statusline+=\  

" ヴィジュアルモード時に選択中の文字列を取得する。
function! s:GetSelectString()
	if visualmode() != mode()
		" ヴィジュアルモード時以外は動作させない。
		return	''
	endif

	" 直接取得できないため、一旦ヤンクする。

	" 古いレジスタを退避
	let l:old_reg_val	=	getreg('a')
	let l:old_reg_mod	=	getregtype('a')
	let l:old_regd_val	=	getreg('"')
	let l:old_regd_mod	=	getregtype('"')

	" ヤンクしてその内容を習得
	silent normal! "ay
	let l:result	=	@a

	" 古いレジスタを戻す
	call setreg( 'a', l:old_reg_val, l:old_reg_mod )
	call setreg( '"', l:old_regd_val, l:old_regd_mod )

	" 選択状態を戻す
	silent normal gv

	return	l:result
endfunction

" ヴィジュアルモードで選択中の文字数をカウントする。
function! b:visual_charcnt()
	" 選択中の文字列を取得して素直にstrlen
	let l:str	=	s:GetSelectString()
	let l:len	=	strlen( l:str )

	" 文字数を表示
	return ( 0 != l:len )? '[' . l:len . ']' : ''
endfunction

" 最初の1回がなぜかうまくいかないので・・・
silent normal! vv

" }}}
" =============================================================

" =============================================================
" {{{ ステータスラインの色を状態によって変更
"	alwei さんからぱくってきた。

let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
	augroup InsertHook
		autocmd!
		autocmd InsertEnter * call s:StatusLine('Enter')
		autocmd InsertLeave * call s:StatusLine('Leave')
	augroup END
endif
" if has('unix') && !has('gui_running')
"   " ESCですぐに反映されない対策
"   inoremap <silent> <ESC> <ESC>
" endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
	if a:mode == 'Enter'
		silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
		silent exec g:hi_insert
	else
		highlight clear StatusLine
		silent exec s:slhlcmd
		redraw
	endif
endfunction

function! s:GetHighlight(hi)
	redir => hl
	exec 'highlight '.a:hi
	redir END
	let hl = substitute(hl, '[\r\n]', '', 'g')
	let hl = substitute(hl, 'xxx', '', '')
	return hl
endfunction

"
" }}}
" =============================================================

" =============================================================
" {{{ 行末のスペースをハイライトする
"	調整中

function! s:HighlightTrailingSpaces ()
	highlight WhitespaceEOL ctermbg=red guibg=red
	match WhitespaceEOL /\s　\+$/
endfunction

augroup TailHiLight
	au! *
	au BufNewFile,WinEnter * call s:HighlightTrailingSpaces()
augroup END

" }}}
" =============================================================

" =============================================================
" {{{ やりたいこと。
"
" ファイルのオープンを常に相対パスで。
"
" }}}
" =============================================================
