" =============================================================
" {{{ 基本設定
" 長いので分割すべきかも

scriptencoding utf-8

" カレント .vimrc, .exrc などを読まない
set noexrc

" エンコード云々
set encoding=utf-8 fileencodings=utf-8,ucs-bom,iso-2022-jp,euc-jp,cp932
set fileformat=unix fileformats=unix,dos,mac

" 背景色を指定することで文字色を設定
set background=dark
" set background=light
colorscheme desert

" マウス有効化
set mouse=nch
set ttymouse=xterm2
set nu
set clipboard+=autoselect

" 改行コードの自動認識
set fileformats=unix,dos,mac

" 外部からのファイル書き換えを検出した場合に自動読込
set autoread

" コマンドの内容をステータス行に表示
set showcmd

" 長い行を折り返しなしに
set nowrap

" 無名レジスタに入るデータを*レジスタにも入れる。
set clipboard+=unnamed

" ファイル名補完をシェルと同じように。
set wildmode=list:longest

" 検索結果のハイライト
set hlsearch
" ハイライトを消しておく。
nohlsearch

" 構文フォントカラー
syntax enable

" 検索時の大文字小文字を区別しない
set ignorecase
" set wildignorecase
" 検索する文字に大文字が1つでも入っていた場合は、大文字小文字を区別する。
set smartcase
" 検索が最後の時に最初へ戻らないように
set nowrapscan
" リアルタイム検索
set incsearch

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
augroup MyQuickFix
	autocmd!
	autocmd QuickfixCmdPost make,grep,grepadd,vimgrep if len(getqflist()) != 0 | copen | resize 5 | execute "normal! J" | endif
	autocmd BufReadPost,WinEnter quickfix resize 5 | normal! J
augroup END

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
set list	"やっぱ見にくかった。
" 改行、タブ文字の設定
"set listchars=tab:^\ ,trail:-
set listchars=tab:\>\ ,trail:%,extends:>,precedes:<
"tab:タブ:	
"trail:行末のスペース: 

" vimdiff
set diffopt=filler,iwhite

" シェルの区切り文字
set shellslash

" 括弧のペア
set matchpairs+=<:>

" 修正個数の報告
set report=0

" <C-a>/<C-x> での増減
" <C-a>を潰している事実が悩みどころ
" set nrformats=alpha,hex

" swap
" どうするか考え中
"set noswapfile

" バックアップ
set nobackup

" screenと一緒に使った時の表示の崩れがなくなるらしい。
set t_Co=256

" オプションのトグル
command! -bar -nargs=1 Tgl call s:toggle_option( '<args>' )
function! s:toggle_option(option_name)
	execute 'setlocal' a:option_name.'!'
	execute 'setlocal' a:option_name.'?'
endfunction

"起動時のメッセージを消す
set shortmess& shortmess+=I

" 現在行を下線に変更.
highlight CursorLine gui=underline guifg=NONE guibg=NONE

" 折り畳みを下線に変更.
highlight Folded term=underline cterm=underline gui=underline ctermbg=NONE guibg=NONE

" }}}
" =============================================================

" =============================================================
" {{{ ファイル読み込み時の処理
function! s:BufAdd()
	" 文字コードの自動認識 ついでなんでここに書く。
	source $HOME/.vim/conf/encode.vim

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
" {{{ ファイルを保存した時に、保存先のものを自動で開く

augroup AutoNewFileWriteOpen
	au!
	" 副作用があったら消す。
	" 副作用があったら消す。
	" 副作用があったら消す。
	au BufWrite * saveas <afile>
	" 副作用があったら消す。
	" 副作用があったら消す。
	" 副作用があったら消す。
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
" ftplugin で設定されているため、
" after/ftplugin/*.vim で設定するようにする。
"set formatoptions-=ro

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

" 努力の跡
set iminsert=0
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
	\	if &l:omnifunc ==# ''
	\	|	setlocal omnifunc=syntaxcomplete#Complete
	\	|endif

	" 素直に設定すると、コメントアウトされている括弧にも反応してしまう。
	" ftpluginに書くべき？
	if 1
		autocmd FileType c,cpp,h,hpp,php,cs
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
\	if &l:omnifunc ==# ''
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
set statusline+=[%{&ff}]				" 改行コード
set statusline+=[%{&enc}]				" 文字コード
set statusline+=:%t						" ファイル名

" 重すぎて使い物にならない。
"set statusline+={%{b:FuncName()}}		" 関数名 cpp とかだけにしたいなぁ。

set statusline+=%m						" 修正フラグ
set statusline+=%r						" 読み込み専用フラグ
set statusline+=%w						" プレビューウィンドウフラグ
set statusline+=%{b:WrapMode()}			" 折り返し

set statusline+=%=						" 左と右の境界

"エラーが出たりカーソル位置がずれたり散々だった。
"set statusline+=%{b:visual_charcnt()}\ 	" ヴィジュアルモード時に選択している文字の数

set statusline+=(%l,%v)					" カーソル位置
set statusline+=[%B]					" カーソル下の文字コード
set statusline+=\ %p%%					" ファイル内のページの位置
set statusline+=\  

" 最初の1回がなぜかうまくいかないので・・・
silent normal! vv

" 今いるところの関数名を取得
" namespaceとかclassとかそういうのは未対応
function! b:FuncName()
	" 今居る位置を保存
	let l:oldpos=getpos('.')

	" {{{ 関数名のあるところまで移動。
		" 一番外側にある '{' まで飛ぶ。
		call searchpairpos( '{', '', '}', 'brW' )
		" その前のブロックへ飛ぶ
		call searchpos( '^$\|}', 'b' )
		" 次にある ( へ飛ぶ
		let l:pos=searchpos( '(' )
	" }}}

	if 0 != l:pos[0] && 0 != l:pos[1]
		" 存在を確認したので関数名を取得
		let l:result=getline( l:pos[0] )
		let l:result=substitute( l:result, '^[0-9a-zA-Z\s<>&*]*\s\+', '', 'g' )
		let l:result=substitute( l:result, '(.*$', '', 'g' )
	else
		" 存在を確認できなかったのでダミー
		let l:result=''
	endif

	" 元居た位置へ戻る。
	call setpos( '.', l:oldpos )

	" 関数名を返す。
	"echo l:result
	return l:result
endfunction

function! b:WrapMode()
	if &wrap
		return	'[wrap]'
	endif
	return	''
endfunction

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
	if a:mode ==# 'Enter'
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
" {{{カーソルの位置を復元

autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"zv" |
	\ endif

" }}}
" =============================================================

" =============================================================
" {{{ vimrc記述支援

" tyruさんから
command!
\   -bar -nargs=1 -complete=customlist,feature_list_excomplete#complete
\   Has
\   echo has(<q-args>)

" }}}
" =============================================================

" =============================================================
" {{{ エンコード系

command! -bang -bar -complete=file -nargs=? Cp932 edit<bang> ++encoding=cp932       <args>
command! -bang -bar -complete=file -nargs=? Eucjp edit<bang> ++encoding=euc-jp      <args>
command! -bang -bar -complete=file -nargs=? Jis   edit<bang> ++encoding=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? Utf8  edit<bang> ++encoding=utf-8       <args>
command! -bang -bar -complete=file -nargs=? Dos   edit<bang> ++fileformat=dos       <args>
command! -bang -bar -complete=file -nargs=? Mac   edit<bang> ++fileformat=mac       <args>
command! -bang -bar -complete=file -nargs=? Unix  edit<bang> ++fileformat=unix      <args>

" }}}
" =============================================================

" =============================================================
" {{{ やりたいこと。
"
" ファイルのオープンを常に相対パスで。
" 置換したあと検索ハイライトしないようにする。
" -> let @/ = "" で潰す？ -> イベントない・・・orz
"
" }}}
" =============================================================
