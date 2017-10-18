set nocompatible               " Use Vim settings, rather then Vi settings (much better!)
filetype off                   " required for Vundle

" Vundle init begin https://github.com/VundleVim/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'  " let Vundle manage Vundle, required
Plugin 'jlanzarotta/bufexplorer'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-endwise'
Plugin 'dareg/vim-cpp'
"Plugin 'chase/vim-ansible-yaml'
Plugin 'avakhov/vim-yaml'
call vundle#end()              " required
filetype plugin indent on      " required
" Vundle init end

set hlsearch                   " highlight search results
set history=1000               " search and commands history
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set laststatus=2               " show current buffer filename in status line
set ruler		       " show cursor position
set hidden                     " keep unsaved data in background buffers
set textwidth=0                " disable auto wrap

syntax on                      " Enable syntax highlighting
filetype on                    " Enable filetype detection
filetype indent on             " Enable filetype-specific indenting
filetype plugin on             " Enable filetype-specific plugins
compiler ruby                  " Enable compiler support for ruby

hi Search cterm=NONE ctermfg=black ctermbg=yellow

" BufExplorer on Ctrl+B
map <C-b> :BufExplorer<cr>

" prev/next buf on Ctrl+up/down
nnoremap <silent> <C-Up>   :bp<CR>
nnoremap <silent> <C-Down> :bn<CR>

nmap o <C-o>
"nmap ] <C-]>
"nmap [ <C-o>

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\     if line("'\"") > 0 && line ("'\"") <= line("$") |
\         exe "normal g'\"" |
\     endif |
\ endif

" allow commands input in russian
"set langmap=йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э',яz,чx,сc,мv,иb,тn,ьm,б\\,,ю.,ё`,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Э\\",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>,Ё~

" ======================== OLD ==========================

"source ~/.vim/vimrc
au FileType ruby,eruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
au BufRead,BufNewFile /etc/nginx/*.conf set ft=nginx 
au BufRead,BufNewFile *.rl set ft=ragel
au BufRead,BufNewFile *.rb set ts=2 sw=2 expandtab
au BufRead,BufNewFile *.txt set textwidth=0
au BufRead,BufNewFile *.pp set ft=ruby                      " puppet
au BufRead,BufNewFile Capfile set ft=ruby                   " capistrano
au BufRead,BufNewFile *.py set sw=4 ts=4 expandtab

" strip excess whitespace on save
"au BufWritePre *.rb :%s/\s\+$//e
"au BufWritePre *.erb :%s/\s\+$//e
"au BufWritePre *.rhtml :%s/\s\+$//e

" adfox
au BufRead,BufNewFile *.cpp,*.hpp,*.h,*.inc,*.cc,*.cmake,CMakeLists.txt set ts=4 sw=4 expandtab tags=tags,../tags cino=N-sf1s{1s(4i8h0
au BufRead,BufNewFile ~/adfox/sourc*/*.lua set ts=4 sw=4 expandtab
au BufRead,BufNewFile ~/adfox/sourc*/*.inc set filetype=cpp indentexpr=
au BufRead,BufNewFile *.cql set syntax=sql ts=4 sw=4 expandtab
au BufRead,BufNewFile *.pp  set ts=4 sw=4 expandtab
au BufRead,BufNewFile *.php set ts=4 sw=4 expandtab
au BufRead,BufNewFile *.go  set ts=4 sw=4 expandtab syntax=c
au BufRead,BufNewFile *Dockerfile*     set ts=4 sw=4 expandtab

"au BufRead,BufNewFile ~/adfox/sourc*/* set ts=4 sw=4 expandtab tags=tags,../tags cino=f1s{1s(4
"au BufRead,BufNewFile ~/sourc*/*       set ts=4 sw=4 expandtab tags=tags,../tags cino=f1s{1s(4
"au BufRead,BufNewFile *.cc,*.cpp       set ts=4 sw=4 expandtab tags=tags,../tags cino=f1s{1s(4
"au BufRead,BufNewFile *.conf           set ts=4 sw=4 expandtab
"au BufRead,BufNewFile *.rb set ft=ruby ts=2 sw=2 expandtab

colorscheme torte
"colorscheme vibrantink
"set nu
"set sts=2
"set sw=2
let g:fuzzy_ignore = "gems/*"

map <C-p> :s/^[a-zA-Z].*/<p>\0<\/p><CR>
"map <C-h>3 :s/^[a-zA-Z].*/<h3>\0<\/h3><CR>
"map <C-h>4 :s/^[a-zA-Z].*/<h4>\0<\/h4><CR>

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
"let &t_SI .= "\<Esc>[?2004h"
"let &t_EI .= "\<Esc>[?2004l"
"inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" toggle between cpp/h
nmap <C-h> :call ToggleFile()<CR>
function! ToggleFile()
ruby <<EOF
  extensions = %w'h hpp c cc cpp inc'
  #cur_fname = VIM::Buffer.current.name
  cur_fname = VIM::evaluate("@%")
  cur_ext   = File.extname(cur_fname).to_s.tr('.','')
  cur_bname = cur_fname.sub(/#{Regexp::escape(cur_ext)}$/,'')
  if idx = extensions.index(cur_ext)
    # found current extension in array
    (idx+1).times do
      extensions.push(extensions.shift)
    end
  end
  found = false
  extensions.each do |ext|
    fname = cur_bname + ext
    if File.exist?(fname)
      VIM.command("e #{fname}")
      found = true
      break
    end
  end
  # atlas
  if !found && cur_fname =~ /\.yml$/ && File.dirname(cur_fname) =~ /atlas.in$/
    fname = cur_fname.sub("atlas.in/", "atlas.out/").sub(".yml",".auto.hpp")
    if File.exist?(fname)
      VIM.command("e #{fname}")
    end
  end
EOF
endfunction

" show current function name when 'f' pressed
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map f :call ShowFuncName() <CR>
