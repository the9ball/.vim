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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 改行時の挙動をいい感じにする {{{
inoremap <buffer><expr> <Enter> <SID>Enter(0)
function! <SID>Enter(ofs)
	let l:result=""
	let l:now=substitute(getline(line(".") - a:ofs), "^\\t*", "", "")

	" 補完中ならキャンセル
	if pumvisible()
		let l:result=l:result."\<C-e>"
	endif

	" TODO:-以外の*とか+とかそのあたりに対応

	" 現在の行への処理
	if l:now =~ '^-\s\?$' || l:now =~ '^\d.\s\?$' || l:now =~ '^$'
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
	elseif l:now =~ '^\d\.'
		let l:result=l:result."1. "
	else
		let l:result=l:result."- "
	endif

	return l:result
endfunction
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 箇条書きのタイプをトグルする {{{
inoremap <buffer><expr> <C-s> <SID>ToggleType()
function! <SID>ToggleType()
	let l:result=""

	let l:now=substitute(getline("."), "^\\t*\\([^ ]\\+\\).*$", "\\1", "")
	if l:now =~ "-"
	  let l:result="\<C-o>:\<C-u>s/^\\t*\\zs-/1./\<Enter>"
	elseif l:now =~ '\d\+\.'
	  let l:result="\<C-o>:\<C-u>s/^\t*\\zs\\d\\./-/\<Enter>"
	endif

	return l:result
endfunction
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 折りたたみ設定 {{{
" #毎に折りたたむ
" ただし、#の行の前には空行が必須
" ##とか###とかは無視
setlocal fdm=expr fde=GetMyMarkdownFoldLevel(v:lnum)
function! GetMyMarkdownFoldLevel(lnum)
	if getline(a:lnum + 2) =~ '^# '
		return '<1'
	elseif getline(a:lnum + 1) =~ '^# '
		return 0
	else
		return 1
	endif
endfunction
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" リスト表示 {{{
nnoremap <buffer> <C-l> :<C-u>call <SID>Tablaize()<Enter>
inoremap <buffer> <C-l> <C-o>:<C-u>call <SID>Tablaize()<Enter>
function! <SID>Tablaize()
	let l:pos=getcurpos()
	let l:nowline=l:pos[1]
	let l:line=getline(l:nowline)
	call append(l:nowline, substitute(l:line, '|\zs[^|]*\ze|', '  ', 'ge'))
	call append(l:nowline, substitute(l:line, '|\zs[^|]*\ze|', '----', 'ge'))

	let l:pos[1] = l:pos[1] + 2 " row
	let l:pos[2] = 3 " column
	call setpos('.', l:pos)

	startinsert
endfunction
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO {{{
" TODO:インデント変えたら(下げたら)箇条書きタイプを変える
" TODO:行の途中で改行した時に末尾の"  "を追加する
" TODO:箇条書き無しバージョンに対応("  "があったら無視する？)
" TODO:プラグイン化(オプションにする項目の洗い出しレベルから)
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
