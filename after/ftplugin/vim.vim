" 改行時にコメントしない
set formatoptions-=ro

" vimscript再読み込み
" いいマッピングが見つからない。
nnoremap <buffer> <Space>w :w<CR>:source %<CR>

" コメントアウト
vnoremap <buffer> <silent> " :s/^\(\s*\)/\1\" /e<CR>gv:s/^\(\s*\)\" \" /\1/e<CR>:<C-u>nohlsearch<CR>
