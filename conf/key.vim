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
command! -nargs=0 Mkcd :make -j8 CCPROG=ccache
nnoremap <S-m> :wa<CR>:make %:t:r.o<CR><CR>

" 指定のプログラムをkill
command! -nargs=1 Killer :!pgrep <args>|xargs kill -9

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
nnoremap <silent> <Space><Space> :cclose<CR>

" }}}
" =============================================================

" =============================================================
"	vimdiff 用設定
" {{{

if	&diff
	" git mergetool の vimdiff 時のマージに使う。 <leader> == ￥
	nnoremap <leader>1 :diffget LOCAL<CR>
	nnoremap <leader>2 :diffget BASE<CR>
	nnoremap <leader>3 :diffget REMOTE<CR>

	" 次へと前へ
	nnoremap <leader>n ]c
	nnoremap <leader>b [c
endif

" }}}
" =============================================================

