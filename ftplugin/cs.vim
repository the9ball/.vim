" コード検索
if !HasPlugin( 'qfixgrep' )
	" カーソル下の単語をソースから検索
	nnoremap sfs :<C-u>vim /\<<C-r><C-w>\>/j **/*.cs<CR>
endif

if HasPlugin('Omnisharp')
	" omini sharp用
	if !exists('g:neocomplcache_force_omni_patterns')
		let g:neocomplcache_force_omni_patterns = {}
	endif
	let g:neocomplcache_force_omni_patterns.cs = '[^.]\.\%(\u\{2,}\)\?'

	nnoremap <silent> MD :<C-u>OmniSharpGotoDefinition<CR>
	nnoremap <silent> MU :<C-u>OmniSharpFindUsages<CR>
	nnoremap <silent> MI :<C-u>OmniSharpFindImplementations<CR>
	nnoremap <silent> MR :<C-u>OmniSharpRename<CR>
	nnoremap <silent> MX :<C-u>OmniSharpGetCodeActions<CR>
"	nnoremap <silent> M :<C-u><CR>
endif

