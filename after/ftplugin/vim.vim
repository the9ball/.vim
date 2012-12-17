" 改行時にコメントしない
set formatoptions-=ro

" vimscript再読み込み
" いいマッピングが見つからない。
nnoremap <buffer> <Space>w :w<CR>:source %<CR>

" コメントアウト
vnoremap <buffer> <silent> " :s/^\(\s*\)/\1\" /e<CR>gv:s/^\(\s*\)\" \" /\1/e<CR>:<C-u>nohlsearch<CR>

" ブロック
nnoremap <silent> block :InsertBlock<CR>
command! -bar -nargs=0 InsertBlock call s:insertBlock()
function! s:insertBlock()
	call append( a:firstline-1, "\" =============================================================" )
	call append( a:firstline+0, "\" {{{ " )
	call append( a:firstline+1, "" )
	call append( a:firstline+2, "" )
	call append( a:firstline+3, "" )
	call append( a:firstline+4, "\" }}}" )
	call append( a:firstline+5, "\" =============================================================" )
	call cursor( line(".")-4, 0 )
endfunction

