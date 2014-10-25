" コード検索
if !HasPlugin( 'qfixgrep' )
	" カーソル下の単語をソースから検索
	nnoremap sfs :<C-u>vim /\<<C-r><C-w>\>/j **/*.cs<CR>
endif

if HasPlugin('Omnisharp')
	autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

	" omini sharp用 neocomplete設定
	if HasPlugin('neocomplete')
		if !exists('g:neocomplete#sources#omni#input_patterns')
			let g:neocomplete#sources#omni#input_patterns = {}
		endif
		if !exists('g:neocomplete#sources')
			let g:neocomplete#sources = {}
		endif
		let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'
		let g:neocomplete#sources.cs = ['omni']
	endif

	nnoremap <silent> MD :<C-u>OmniSharpGotoDefinition<CR>
	nnoremap <silent> MU :<C-u>OmniSharpFindUsages<CR>
	nnoremap <silent> MI :<C-u>OmniSharpFindImplementations<CR>
	nnoremap <silent> MR :<C-u>OmniSharpRename<CR>
	nnoremap <silent> MX :<C-u>OmniSharpGetCodeActions<CR>
"	nnoremap <silent> M :<C-u><CR>
endif

