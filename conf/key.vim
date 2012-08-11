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
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" }}}
" =============================================================

" =============================================================
" {{{ ヴィジュアルモード

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
" {{{ ノーマルモード

" xで削除した時にレジスタに載せない。
nnoremap x "_x

" jkでのカーソル移動を表示行単位で行う
nnoremap gj j
nnoremap gk k
" accelerated-jk で使うので一旦無効化。
" 廃止するときは戻す。
" nnoremap j gj
" nnoremap k gk

" 簡単移動
nnoremap <C-a> <Home>
nnoremap <C-e> <End>

" D とか C とか互換
" 標準の Y は yy と同義らしい。
nnoremap Y y$

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

" 開いているバッファを閉じる
nnoremap <C-z> :<C-u>bdel<CR>

" 誤爆防止
" でも結構頻繁に使う。
nnoremap q <ESC>
nnoremap Q q
nnoremap <C-q> q

" 誤爆防止
nnoremap S <Nop>
nnoremap s <Nop>

" }}}
" =============================================================

" =============================================================
" {{{ インサートモード

" ファイル名補完ショートカット
" CTRL+F でファイル名補完
inoremap <silent> <C-f> <C-x><C-f>

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

" 簡単移動
inoremap <C-a> <Home>
inoremap <C-e> <End>

" }}}
" =============================================================

" =============================================================
" {{{ タブ

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
" {{{ バッファ

" Unite buffer で十分
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
endif

" }}}
" =============================================================

" =============================================================
" {{{ コード入力

" 同じ名前のヘッダを開く
nnoremap <silent> sh :<C-u>hide edit %<.h<CR>	
" 同じ名前のソースを開く
nnoremap <silent> ss :<C-u>hide edit %<.cpp<CR>

" いろんなメイク
command! -bar -nargs=* Mkcd :execute "make -j8 CCPROG=ccache RELEASE=1 " . expand( '<args>' )
command! -bar -nargs=* Mkcdd :execute "make -j8 CCPROG=ccache " . expand( '<args>' )
nnoremap <S-m> :wa<CR>:execute "make RELEASE=1 CCPROG=\'\' " . expand( '%:t:r' ) . ".o"<CR><CR>

" 指定のプログラムをkill
command! -bar -nargs=1 Killer :!pgrep <args>|xargs kill -9

" コメントアウト
vnoremap <silent> / :s/^\(\s*\)/\1\/\//e<CR>gv:s/^\(\s*\)\/\/\/\//\1/e<CR>:nohlsearch<CR>

" なぜか効かない・・・？
" vnoremap <silent> # :s/^\(\s*\)/\1# /e<CR>gv:s/^\(\s*\)# # /\1/e<CR>:nohlsearch<CR>

" 括弧とかとか
nnoremap <silent> ;{} :FunctionHelperCommand<CR>
command! -bar -nargs=* FunctionHelperCommand call s:functionHelper()
function! s:functionHelper()
	silent! exec 's/;$//'
	silent normal! o{
	silent normal! o}
	exec 'nohlsearch'
endfunction

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
" 使ってないので削除候補
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
"nnoremap <silent> <C-h> :<C-u>nohlsearch<CR>
" ESCの方がよさそうだけどもう慣れちゃってるからなぁ・・・。
nnoremap <silent> <ESC> :<C-u>nohlsearch<CR>

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

nnoremap memo :MemoSeparate<CR>
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

