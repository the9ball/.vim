" 同じ名前のヘッダを開く
nnoremap <silent> sh :<C-u>hide edit %<.h<CR>
" 同じ名前のソースを開く
nnoremap <silent> ss :<C-u>hide edit %<.cpp<CR>

" 括弧とかとか
nnoremap <silent> ;{} :FunctionHelperCommand<CR>
command! -bar -nargs=* FunctionHelperCommand call s:functionHelper()
function! s:functionHelper()
	silent! exec 's/;$//'
	silent normal! o{
	silent normal! o}
	exec 'nohlsearch'
endfunction
