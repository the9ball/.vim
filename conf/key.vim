scriptencoding utf-8

" =============================================================
" {{{ メモ

" <C-k> + 特殊キー で特殊キー入力

" テンキーを数字キーに
" 要検証
" ウィンドウサイズの方で運用するようにする。
" map Op 0
" map Oq 1
" map Or 2
" map Os 3
" map Ot 4
" map Ou 5
" map Ov 6
" map Ow 7
" map Ox 8
" map Oy 9

" <C-m> は <CR> と同義
" <CR> は Enterキー と同義

" なんかよくわかんないけど、Macだと<C-s>がうまく動かない。
" 何かの設定が邪魔してるのかなぁ・・・。

" }}}
" =============================================================

" =============================================================
" {{{ 特殊キー対応

" テンキーのEnterを通常のEnterに。
map OM <CR>

" 入力時は数値として認識させる。
" TeraTerm用
" なんかうまくいかない。
" inoremap 0p 0
" inoremap 1q 1
" inoremap 2r 2
" inoremap 3s 3
" inoremap 4t 4
" inoremap 5u 5
" inoremap 6v 6
" inoremap 7w 7
" inoremap 8x 8
" inoremap 9y 9
" inoremap . .
" inoremap / /
" inoremap * *
" inoremap - -
" inoremap + +
" inoremap OM <CR>	上にある

" }}}
" =============================================================

" =============================================================
" {{{ コマンドモード

" コマンドモードのディレクトリ補完
cnoremap <c-x> <c-r>=expand('%:p:h')<cr>/
cnoremap <c-z> <c-r>=expand('%:p')<cr>

" カーソルキーっぽく
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
"cnoremap <C-h> <Left>	BSとかぶる。
cnoremap <C-l> <Right>
cnoremap <C-a> ^
cnoremap <C-e> <End>

" 誤爆というかイライラ防止
" どうもうまくいかない・・・。
" <C-v><C-Space>だとファイルがバイナリ扱いになるはめに・・・。
"cnoremap <C-Space> <Space>

" }}}
" =============================================================

" =============================================================
" {{{ ヴィジュアルモード

" 範囲選択の上書きペーストでレジスタに載せない。
" 終端を上書きたい時に変な感じになる。
vnoremap p "_dP
vnoremap P "_dP
vnoremap c "_c
vnoremap C "_C
vnoremap <C-r> "_c<C-r>

" 範囲選択時のワード単位移動をワードの先頭ではなく、終端に。
" w連打で次のワードへ移動しないため結局使いにくい。
" vnoremap w wh

" 簡単移動
vnoremap <C-a> ^
vnoremap <C-e> <End>

" 範囲選択中に結合させないようにしたい。
vnoremap J j
vnoremap <C-j> j

" visual モードで連続して、インデント出来るように設定
vnoremap <silent> > >gv
vnoremap <silent> < <gv

	" =============================================================
	" {{{ ヴィジュアルモードで選択中の文字数をカウントする。

	" ヴィジュアルモード時に選択中の文字列を取得する。
	function! s:GetSelectString()
		if visualmode() != mode()
			" ヴィジュアルモード時以外は動作させない。
			silent normal! gv
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

	function! s:visual_charcnt()
		" 選択中の文字列を取得して素直にstrlen
		let l:str	=	s:GetSelectString()
		let l:len	=	strlen( l:str )

		" 文字数
		echo "Length : " . l:len
		call getchar()
	endfunction
	command! -nargs=0 -range Count call s:visual_charcnt()
	vnoremap q :Count<CR>

	" }}}
	" =============================================================

	" =============================================================
	" {{{ ヴィジュアルモード時に行番号を消す。

	" TODO 直前に表示状態かどうかを確認して、戻す際にいい感じにする。
	"      どうせ表示してるからとりあえずは気にしない。
	" と、思ったけどヴィジュアルモードからの出口ありすぎ・・・
	if 0
		nnoremap <silent> v :<C-u>set nonumber<CR>v
		nnoremap <silent> <C-v> :<C-u>set nonumber<CR><C-v>
		nnoremap <silent> <S-v> :<C-u>set nonumber<CR>V
		vnoremap <silent> <ESC> :<C-u>set number<CR><ESC>
	endif

	" }}}
	" =============================================================

" }}}
" =============================================================

" =============================================================
" {{{ ノーマルモード

" 誤爆防止
" sとか後で定義しなおしてるけど。
nnoremap S <Nop>
nnoremap s <Nop>
nnoremap ZZ <Nop>

" xで削除した時にレジスタに載せない。
nnoremap x "_x
nnoremap X "_X

" jkでのカーソル移動を表示行単位で行う
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" スクロール
nnoremap <C-k> <C-y>
nnoremap <C-j> <C-e>

" 簡単移動
nnoremap <C-a> ^
nnoremap <C-e> <End>

" 片手で移動
nnoremap , <C-u>zz
nnoremap m <C-d>zz

" D とか C とか互換
" 標準の Y は yy と同義らしい。
nnoremap Y y$

" 読み込まれたスクリプト一覧
nnoremap <F3> :<C-u>scriptnames<CR>
" マップされたキー一覧
nnoremap <F2> :<C-u>verbose map<CR>

" 直前に実行したコマンドを再度実行
nnoremap <Space><CR> :<Up><CR>

" 上書き
nnoremap <silent> <Space>w :w<CR>

" ファイル名のヤンク
nnoremap <silent> yf :call setreg( '"', expand( '%:t' ) )<CR>
nnoremap <silent> yp :call setreg( '"', expand( '%:p' ) )<CR>

" 誤爆防止
" でも結構頻繁に使う。
nnoremap q <ESC>
nnoremap Q q
nnoremap <C-q> q

" デフォルト潰すのがあれだけど、<C-w>j/k/l/hで移動するから問題ないはず。
nnoremap <silent> <C-w><C-w> :<C-u>set wrap!<CR>

" バッファ移動
nnoremap <silent> bp :<C-u>bprevious<CR>
nnoremap <silent> bn :<C-u>bnext<CR>

" 検索は別項目

" {{{ command-line-window
	" 補完できるし意外と便利なのかも。
	nnoremap : q:i
	function! b:MyCmdWinEnter()
		" ESCで閉じたい。
		nnoremap <buffer><silent> <Esc> <CR>
		inoremap <buffer><silent> <Esc> <C-o>o<CR>

		" 履歴の参照
		inoremap <buffer><silent> <C-k> <C-g>k
		inoremap <buffer><silent> <C-j> <C-g>j

		" 過去のコマンドをコピー
		inoremap <buffer><silent> <C-y> <Esc>"zy$GC<C-r>z

		" 左右移動したくなった。
		inoremap <buffer><silent> <C-f> <C-o>a
		inoremap <buffer><silent> <C-b> <C-o>h
		inoremap <buffer><silent> <C-l> <C-o>l
		
		if g:has_plugin( 'neobundle' )
			inoremap <buffer><silent> <Tab> <C-n>
		endif

		" 高いと邪魔
		" なんかエラーだってよ
		"resize 3
	endfunction
	augroup MyCmdwinEnter
		autocmd!
		autocmd CmdwinEnter * call b:MyCmdWinEnter()
	augroup END
" }}}

" {{{ ターミナルからのコピー用に・・・
function! s:_CopyTabClose()
	" 終了時の挙動
	nmapclear <buffer>
	delcommand CopyTabClose
	augroup COPY_TAB
		autocmd!
	augroup END
	tabclose
	
	normal! zv
endfunction
function! s:_CopyTab()
	tabnew %
	set nonumber
	normal! "i"

	command CopyTabClose call s:_CopyTabClose()

	" インサートモードから離れたらタブを閉じたい。
	" でもバッファローカルなautocmdしか定義できないので
	" 閉じた後にコマンドを未定義状態にする。
	augroup COPY_TAB
		autocmd!
		autocmd InsertLeave <buffer> silent CopyTabClose
	augroup END
	nmap <buffer><silent> <ESC> :CopyTabClose<CR>
endfunction
command! CopyTab call s:_CopyTab()
nnoremap <silent> tt :<C-u>CopyTab<CR>
" }}}

" Win用
if g:is_win
" .gvimrc に書くべきかもしれないけど
" マッピングを検索しやすいように・・・。
" ウィンドウ最大化
"nnoremap <silent> <C-w><Tab> :<C-u>simalt ~x
" 自動化の方がいい？
au GuiEnter * simalt ~x
" 「simalt ~n」 で最小化
endif

" }}}
" =============================================================

" =============================================================
" {{{ インサートモード

" スペルチェック ON/OFF
function! s:completeSpellCheckOff()
	if 0 == pumvisible()
		" ポップアップメニューが出ていない。
		set nospell
		aug completeSpellCheck
			au! * <buffer>
		aug END
	endif
endfunction
function! s:completeSpellCheckOn()
	set spell
	aug completeSpellCheck
		au! * <buffer>
		au CursorMoved,CursorMovedI <buffer> call s:completeSpellCheckOff()
	aug END
endfunction
command! -bar -nargs=* CompleteSpellCheck :call s:completeSpellCheckOn()
inoremap <C-l> <C-o>:<C-u>CompleteSpellCheck<CR><C-x><C-s>

" 貼り付け時に \<\> の有無を選択できるように。.
function! s:pasteOriginal( word, head, foot )
	" 対象のレジスタの内容を取得
	echo ( ( 0 == a:word )? 'StringMode' : 'WordMode' ) . ':Register:'
	let l:register = nr2char( getchar() )
	if match( l:register, '[a-zA-Z0-9.%#:-\"/]' ) < 0
		echo l:register . ' is Not Register Name'
		return ""
	endif
	let l:string = getreg( l:register )

	" \< \> を削除
	let l:string = substitute( l:string, '^\\<', '', '' )
	let l:string = substitute( l:string, '\\>$', '', '' )

	" 改めて単語単位なら \< \> で囲む
	if a:word
		let l:string = a:head . l:string . a:foot
	endif

	return l:string
endfunction
function! s:pasteOriginalHeadFoot()
	echo 'Head:'
	let l:head = nr2char( getchar() )
	echo 'Foot:'
	let l:foot = nr2char( getchar() )
	return s:pasteOriginal( 1, l:head, l:foot )
endfunction
" 単純に<C-r>でマップするとWinのgvimだと反応が悪かったので・・・。
inoremap <expr> <C-r><C-e> <SID>pasteOriginal( 0, '', '' )
inoremap <expr> <C-r><C-w> <SID>pasteOriginal( 1, '\<', '\>' )
" surround.vim と微妙に用途がかぶってる気がするけど多分気のせい。
inoremap <expr> <C-r><C-r> <SID>pasteOriginalHeadFoot()

" コマンドモードでも。
cnoremap <expr> <C-r><C-e> <SID>pasteOriginal( 0, '', '' )
cnoremap <expr> <C-r><C-w> <SID>pasteOriginal( 1, '\<', '\>' )

" }}}
" =============================================================

" =============================================================
" {{{ タブ

" そもそもタブ使わない・・・
if 0
	" タブ操作キー
	" 新規タブを作成し、移動
	nnoremap <silent> to :<C-u>tabnew<CR>:tabmove<CR>
	" 現在のタブを閉じる
	nnoremap <silent> tc :<C-u>tabclose<CR>
	" 次のタブへ移動
	nnoremap <silent> tn :<C-u>tabnext<CR>
	" 前のタブへ移動
	nnoremap <silent> tp :<C-u>tabprev<CR>
endif

" }}}
" =============================================================

" =============================================================
" {{{ バッファ

" Unite buffer で十分
" と、思いきや意外と使いたい時が多かった。
" CtrlPBuffer で十分 というか<C-[n|p|i|o]>とかで飛んでるとわけがわからなくなる。
if 0
	" バッファ操作キー
	nnoremap s <Nop>
	" ファイルリスト表示
	nnoremap <silent> sl :<C-u>ls<CR>
	" 直前のファイルに飛ぶ
	nnoremap <silent> sf :<C-u>hide b#<CR>
	" 次のファイルへ移動
	nnoremap <silent> sn :<C-u>hide bn<CR>
	" 前のファイルへ移動
	nnoremap <silent> sp :<C-u>hide bp<CR>
	" ファイルを閉じる
	nnoremap <silent> sc :<C-u>bdel<CR>
endif

" }}}
" =============================================================

" =============================================================
" {{{ コード入力

" いろんなメイク
" command! -bar -nargs=* Mkcd :execute "make -j8 CCPROG=ccache RELEASE=1 " . expand( '<args>' )
" command! -bar -nargs=* Mkcdd :execute "make -j8 CCPROG=ccache " . expand( '<args>' )
" silentしてないのに履歴に載らない・・・？
nnoremap <S-m> :wa<CR>:!touch %<CR>:make -r obj/%:t:r.o<CR>
command! -bar -nargs=* Mk :execute "make -r " . expand( '<args>' )
command! -bar -nargs=0 Temp :!git temp

" 指定のプログラムをkill
" ご利用は計画的に
command! -bar -nargs=1 Killer :!pgrep <args>|xargs kill -9

" コメントアウト
vnoremap <silent> / :s/^\(\s*\)/\1\/\//e<CR>gv:s/^\(\s*\)\/\/\/\//\1/e<CR>:nohlsearch<CR>

" なぜか効かない・・・？
" vnoremap <silent> # :s/^\(\s*\)/\1# /e<CR>gv:s/^\(\s*\)# # /\1/e<CR>:nohlsearch<CR>

" 縦に連番を入力する
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/tips#TOC--7
"nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

" }}}
" =============================================================

" =============================================================
" {{{ 検索

" コード検索
" 簡単vimgrep
nnoremap s :<C-u>vim /\<<C-r><C-w>\>/ **/*
" カーソル下の単語をソースから検索
nnoremap sfs :vim /\<<C-r><C-w>\>/ **/*.c*<CR>
" カーソル下の単語をヘッダから検索
nnoremap sfh :vim /\<<C-r><C-w>\>/ **/*.h*<CR>

" 検索結果を中央に
" zvは折りたたみを展開する。
nnoremap n nzzzv
nnoremap N Nzzzv

" *と#の検索で前後に飛ばないように。
" 直後にnやNで飛びたいので/レジスタにセットしておく。
highlight MyQuickSearch ctermbg=grey guibg=grey
nnoremap <silent> * :let @/ = "\\<<C-r><C-w>\\>"<CR>:match MyQuickSearch /<C-r>//<CR>
nnoremap <silent> # :let @/ = "\\<<C-r><C-w>\\>"<CR>:match MyQuickSearch /<C-r>//<CR>
nnoremap <silent> g* :let @/ = "<C-r><C-w>"<CR>:match MyQuickSearch /<C-r>/<CR>
nnoremap <silent> g# :let @/ = "<C-r><C-w>"<CR>:match MyQuickSearch /<C-r>/<CR>

" 検索ハイライトを消す。
nnoremap <silent> <ESC> :nohlsearch<CR>:match none<CR>

" Quickfixを開閉する。
nnoremap <silent> <Space>o :copen<CR>
nnoremap <silent> <Space>c :cclose<CR>

" }}}
" =============================================================

" =============================================================
" {{{ vimdiff 用設定

"if	&diff	これを有効にすると通常時にdiffthisとかをした時に効かない
	" git mergetool の vimdiff 時のマージに使う。 <leader> == ￥
	nnoremap <leader>1 :diffget LOCAL<CR>
	nnoremap <leader>2 :diffget BASE<CR>
	nnoremap <leader>3 :diffget REMOTE<CR>

	" ノーマルな vimdiff 時
	nnoremap <leader>g :diffget<CR>
	nnoremap <leader>p :diffput<CR>

	" 次へと前へ
	nnoremap <leader>n ]czz
	nnoremap <leader>b [czz
"endif

" }}}
" =============================================================

" =============================================================
" {{{ メモ用設定

nnoremap <silent> memo :MemoSeparate<CR>
command! -bar -nargs=0 MemoSeparate call s:memoSeparate()
function! s:memoSeparate()
	call append( a:firstline-1, "###############################################################" )

	call setline('.', getline('.') . strftime('%Y/%m/%d (%a) %H:%M'))

	call append( a:firstline+1, "" )	" 空行挿入
	call append( a:firstline+2, "" )	" 空行挿入
	call cursor( line(".")+2, 0 )
endfunction

" }}}
" =============================================================

