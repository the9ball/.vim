if &filetype != "markdown"
	finish
endif

setlocal tabstop=2 softtabstop=2 shiftwidth=2

" TAB入力でインデント
inoremap <buffer> <Tab> <C-t>
inoremap <buffer> <S-Tab> <C-d>

" oとかで改行した時は改行と同じ感じにする
nnoremap <buffer><expr> o "A".<SID>Enter(0)
nnoremap <buffer><expr> O "kA".<SID>Enter(1)

" 改行時の挙動をいい感じにする
inoremap <buffer><expr> <Enter> <SID>Enter(0)
function! <SID>Enter(ofs)
	let l:result=""
	let l:now=substitute(getline(line(".") - a:ofs), "^\\t*", "", "")

	" 補完中ならキャンセル
	if pumvisible()
		let l:result=l:result."\<C-e>"
	endif

	" 現在の行への処理
	if l:now =~ '^-\s\?$' || l:now =~ '^1.\s\?$' || l:now =~ '^$'
		let l:result=l:result."\<C-o>0\<C-o>\<S-d>"
		let l:now="" " 空行と同じ扱いにする
	endif

	" 改行する
	let l:result=l:result."\<Enter>"

	" 新規の行への処理
	if l:now =~ '^$'
		let l:result=l:result."0\<C-d>"
	elseif l:now =~ '^#\+\s'
		let l:result=l:result."0\<C-d>- "
	elseif l:now =~ '^1\.'
		let l:result=l:result."1. "
	else
		let l:result=l:result."- "
	endif

	echo l:now." => ".l:result
	return l:result
endfunction
