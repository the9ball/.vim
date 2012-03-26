set tabstop=4
set softtabstop=4
" オートインデント時のタブ量
set shiftwidth=4

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

" オートインデント
set autoindent
" C言語形式のインデント
set cindent
" 反映されるか？これ。
" set cinoptions=":0|1g0t0(1su-1U1m1"

" <BS>で文字が消えない問題の対応
set backspace=indent,eol,start

" 長い行を折り返しなしに
set nowrap

" インデントで開閉させる。
set fdm=indent

" 無名レジスタに入るデータを*レジスタにも入れる。
set clipboard+=unnamed

" ファイル名補完をシェルと同じように。
set wildmode=list:longest

" 検索結果のハイライト
set hlsearch

" 構文フォントカラー
syntax enable

" 入力をやめた際にIMEをOFFし、再開時にもとに戻す。
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


" 予約語の補完
 autocmd FileType *
 \	if &l:omnifunc == ''
 \	|	setlocal omnifunc=syntaxcomplete#Complete
 \	|endif

" 検索時の大文字小文字を区別しない
" set ignorecase
" 検索する文字に大文字が1つでも入っていた場合は、大文字小文字を区別する。
" set smartcase
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

" ウィンドウ移動時の処理
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

" Pyclewn の CAttach を引数名で簡単に。
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
	command! -nargs=1 -complete=dir Attach :call g:AttachFunc( <f-args> )
endif


