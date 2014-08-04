"setlocal makeprg=php\ -l\ %
"
"augroup ftplugin_PHP
"	autocmd!
"	autocmd BufWritePost *.php silent make | normal <C-l> | if len(getqflist()) != 1 | copen | else | cclose | endif
"augroup END

if !HasPlugin( 'qfixgrep' )
	nnoremap sfp :<C-u>vim /\<<C-r><C-w>\>/j **/*.php<CR>
endif

