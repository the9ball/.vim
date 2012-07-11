" =============================================================
"	メモ
" {{{

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

" }}}
" =============================================================

" =============================================================
"	特殊キー対応
" {{{

" テンキーのEnterを通常のEnterに。
map OM <CR>

" 入力時は数値として認識させる。
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
" inoremap OM <CR>

" }}}
" =============================================================

" =============================================================
"	コマンドモード支援
" {{{

" コマンドモードのディレクトリ補完
cnoremap <c-x> <c-r>=expand('%:p:h')<cr>/
cnoremap <c-z> <c-r>=expand('%:p')<cr>

" }}}
" =============================================================

" =============================================================
"	ヴィジュアルモード支援
" {{{

" 範囲選択の上書きペーストでレジスタに載せない。
vnoremap p "_dP
vnoremap P "_dP

" 範囲選択時のワード単位移動をワードの先頭ではなく、終端に。
" w連打で次のワードへ移動しないため結局使いにくい。
" vnoremap w wh
" 範囲選択中に結合させないようにしたい。
vnoremap J j
vnoremap <C-j> j

" visual モードで連続して、インデント出来るように設定
vnoremap <silent> > >gv
vnoremap <silent> < <gv

" }}}
" =============================================================

" =============================================================
"	ノーマルモード支援
" {{{

" xで削除した時にレジスタに載せない。
nnoremap x "_x

" jkでのカーソル移動を表示行単位で行う
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" wbでのワード移動時、WBだと行を進めてみる。
" いまいち
" nnoremap W jw
" nnoremap B kb

" ウィンドウサイズを調整
nnoremap Ov 1<C-w>>
nnoremap Ot 1<C-w><
nnoremap Or 1<C-w>+
nnoremap Ox 1<C-w>-

" 読み込まれたスクリプト一覧
nnoremap <F3> :<C-u>scriptnames<CR>
" マップされたキー一覧
nnoremap <F2> :<C-u>verbose map<CR>

" 直前に実行したコマンドを再度実行
nnoremap <Space><CR> :<Up><CR>

"強制全保存終了を無効化
nnoremap ZZ <Nop>

" }}}
" =============================================================

" =============================================================
"	インサートモード支援
" {{{

" ファイル名補完ショートカット
" CTRL+F でファイル名補完
inoremap <silent> <C-f> <C-x><C-f>

" }}}
" =============================================================

" =============================================================
"	タブ
" {{{

" タブ操作キー
" 新規タブを作成し、移動
nnoremap <silent> to :<C-u>tabnew<CR>:tabmove<CR>
" 現在のタブを閉じる
nnoremap <silent> tc :<C-u>tabclose<CR>
" 次のタブへ移動
nnoremap <silent> tn :<C-u>tabnext<CR>
" 前のタブへ移動
nnoremap <silent> tp :<C-u>tabprev<CR>

" }}}
" =============================================================

" =============================================================
"	バッファ
" {{{

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

" }}}
" =============================================================

" =============================================================
"	コード入力支援
" {{{

" コード補助
" 同じ名前のヘッダを開く
nnoremap <silent> sh :<C-u>hide edit %<.h<CR>	
" 同じ名前のソースを開く
nnoremap <silent> ss :<C-u>hide edit %<.cpp<CR>

" いろんなメイク
command! -nargs=* Mkcd :UniteQfHelper( "make -j8 CCPROG=ccache RELEASE=1 " . expand( '<args>' ) )
command! -nargs=* Mkcdd :UniteQfHelper( "make -j8 CCPROG=ccache " . expand( '<args>' ) )
nnoremap <S-m> :wa<CR>:UniteQfHelper( "make RELEASE=1 " . expand( '%:t:r' ) . ".o" )<CR><CR>

" 指定のプログラムをkill
command! -nargs=1 Killer :!pgrep <args>|xargs kill -9

" コメントアウト
vnoremap <silent> / :s/^\(\s*\)/\1\/\//g<CR>gv:s/^\(\s*\)\/\/\/\//\1/g<CR>:nohlsearch<CR>

" }}}
" =============================================================

" =============================================================
"	検索
" {{{

" コード検索
" カーソル下の単語をソースから検索
nnoremap sfs :vim /<C-r><C-w>/ **/*.c*<CR>
" カーソル下の単語をヘッダから検索
nnoremap sfh :vim /<C-r><C-w>/ **/*.h*<CR>

" 検索結果を中央に
map n nzz
map N Nzz
map * *N
map # #N
map g* g*N
map g# g#N

" 検索ハイライトを消す。
nnoremap <silent> <C-h> :nohlsearch<CR>

" Quickfixを開閉する。
nnoremap <silent> <Space>o :copen<CR>
nnoremap <silent> <Space>c :cclose<CR>

" }}}
" =============================================================

" =============================================================
"	vimdiff 用設定
" {{{

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
"	メモ用設定
" {{{

nnoremap memo :MemoSeparate<CR>
command! -nargs=0 MemoSeparate call s:memoSeparate()
function! s:memoSeparate()
	call append( a:firstline-1, "###############################################################" )
	.!date
	call append( a:firstline+1, "" )	" 空行挿入
	call append( a:firstline+2, "" )	" 空行挿入
	call cursor( line(".")+2, 0 )
endfunction

" }}}
" =============================================================
