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

" コード検索
if !HasPlugin( 'qfixgrep' )
	" カーソル下の単語をソースから検索
	nnoremap sfs :<C-u>vim /\<<C-r><C-w>\>/j **/*.cpp<CR>
	" カーソル下の単語をヘッダから検索
	nnoremap sfh :<C-u>vim /\<<C-r><C-w>\>/j **/*.h<CR>
	" カーソル下の単語をヘッダから検索
	" 多分使う機会はないだろうけど、ライブラリ検索用
	nnoremap sfl :<C-u>vim /\<<C-r><C-w>\>/j **/*.hpp<CR>
endif

