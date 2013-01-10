" マップのクリア
" mapc

let g:is_win = has("win16") || has("win32") || has("win64")

" 基本ファイル
source $HOME/.vim/conf/common.vim

" プラグイン
source $HOME/.vim/conf/plugin.vim

" キーバインド
source $HOME/.vim/conf/key.vim

" filetype on した時点で登録済みのファイルタイプしか判定されないらしい。
" on の時に on にしても意味がないらしい。
filetype off
filetype on

