set nocompatible               " Use Vim settings, rather then Vi settings (much better!)
set hlsearch                   " highlight search results
set history=1000               " search and commands history
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set laststatus=2               " show current buffer filename in status line
set ruler		       " show cursor position
set hidden                     " keep unsaved data in background buffers

syntax on                      " Enable syntax highlighting
filetype on                    " Enable filetype detection
filetype indent on             " Enable filetype-specific indenting
filetype plugin on             " Enable filetype-specific plugins
compiler ruby                  " Enable compiler support for ruby

hi Search cterm=NONE ctermfg=black ctermbg=yellow

"allow each plugin to live in ~/.vim/bundle/<plugin>
execute pathogen#infect()

" BufExplorer on Ctrl+B
map <C-b> :BufExplorer<cr>

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\     if line("'\"") > 0 && line ("'\"") <= line("$") |
\         exe "normal g'\"" |
\     endif |
\ endif

" allow commands input in russian
set langmap=йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э',яz,чx,сc,мv,иb,тn,ьm,б\\,,ю.,ё`,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Э\\",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>,Ё~

" ======================== OLD ==========================

"source ~/.vim/vimrc
au FileType ruby,eruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
au BufRead,BufNewFile /etc/nginx/*.conf set ft=nginx 
au BufRead,BufNewFile *.rl set ft=ragel
au BufRead,BufNewFile *.rb set ft=ruby

" strip excess whitespace on save
"au BufWritePre *.rb :%s/\s\+$//e
"au BufWritePre *.erb :%s/\s\+$//e
"au BufWritePre *.rhtml :%s/\s\+$//e

" adfox
au BufRead,BufNewFile ~/adfox/sourc*.cc set ts=4 expandtab

"colorscheme vibrantink
"set nu
"set sts=2
"set sw=2
let g:fuzzy_ignore = "gems/*"

map <C-p> :s/^[a-zA-Z].*/<p>\0<\/p><CR>
map <C-h>3 :s/^[a-zA-Z].*/<h3>\0<\/h3><CR>
map <C-h>4 :s/^[a-zA-Z].*/<h4>\0<\/h4><CR>

set nolist
set wrap

"vmap <C-a> <Esc>`>a</a><Esc>`<i<a href=""><Esc>hi
"vmap <C-b> <Esc>`>a</b><Esc>`<i<b><Esc>

map <C-t> :NERDTreeToggle<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"color peachpuff

map <C-_> :cstag <C-R>=expand("<cword>")<CR><CR>

map <F2> :e ++enc=cp1251 %<CR>
map <F3> :e ++enc=utf-8 %<CR>
map <F4> :e ++enc=ibm866 %<CR>
"map <F5> :e ++enc=koi8-r %<CR>
map <F6> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Пробел в нормальном режиме перелистывает страницы
nmap <Space> <PageDown>

" CTRL-F для omni completion
"imap <C-F> <C-X><C-O>

" goto определения функции по ctrl-f
"nmap <c-f> :cs find g <c-r>=expand("<cword>")<cr><cr>

" C-c and C-v - Copy/Paste в "глобальный клипборд"
vmap <C-C> "+yi
imap <C-V> <esc>"+gPi

" Заставляем shift-insert работать как в Xterm
map <S-Insert> <MiddleMouse>

" F11 - показать окно Taglist
map <F11> :TlistToggle<cr>
vmap <F11> <esc>:TlistToggle<cr>
imap <F11> <esc>:TlistToggle<cr>

" F12 - обозреватель файлов
map <F12> :Ex<cr>
vmap <F12> <esc>:Ex<cr>i
imap <F12> <esc>:Ex<cr>i

" < & > - делаем отступы для блоков
vmap < <gv
vmap > >gv

" Выключаем ненавистный режим замены
imap >Ins> <Esc>i

" Автозавершение слов по tab =)
function InsertTabWrapper()
     let col = col('.') - 1
     if !col || getline('.')[col - 1] !~ '\k'
         return "\<tab>"
     else
         return "\<c-p>"
     endif
endfunction
" imap <tab> <c-r>=InsertTabWrapper()<cr>
" Слова откуда будем завершать
set complete=""
" Из текущего буфера
set complete+=.
" Из словаря
set complete+=k
" Из других открытых буферов
set complete+=b
" из тегов 
set complete+=t



set backupcopy=auto,breakhardlink
set incsearch
"set mouse=a
set mousemodel=popup
set smartindent

set tags=.tags,./tags,./.tags,../.tags,../../.tags,../../../.tags

au FileType yaml set tabstop=2 shiftwidth=2 expandtab

""""""""""""""""""""""""""""""""""""""""""""""""
" comments

" , #perl # comments
map ,# :s/^/#/<CR><Esc>:nohlsearch<CR>

" ,/ C/C++/C#/Java // comments
map ,/ :s/^/\/\//<CR><Esc>:nohlsearch<CR>

" ,< HTML comment
map ,< :s/^\(.*\)$//<CR><Esc>:nohlsearch<CR>

" c++ java style comments
map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR><Esc>:nohlsearch<CR>

" LUA style comments
map ,- :s/^/--/<CR><Esc>:nohlsearch<CR>

" uncomment
map ,u :s/^#//<CR><Esc>:nohlsearch<CR>

""""""""""""""""""""""""""""""""""""""""""""""""
" paste

" paste w/o 'set paste' // from http://www.linux.org.ru/forum/web-development/10662433
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
