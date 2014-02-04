" コード検索
if !g:has_plugin( 'qfixgrep' )
	" カーソル下の単語をソースから検索
	nnoremap sfs :<C-u>vim /\<<C-r><C-w>\>/j **/*.cs<CR>
endif

