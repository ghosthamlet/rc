
set nocompatible

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

behave mswin

set diffexpr=MyDiff()

if has("multi_byte")
    set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
    if v:lang =~ "^zh_CN"
        set encoding=cp936
        set termencoding=cp936
        set fileencoding=cp936
    elseif v:lang =~ "^zh_TW"
        set encoding=big5
        set termencoding=big5
        set fileencoding=big5
    elseif v:lang =~ "^ko"
        set encoding=euc-kr
        set termencoding=euc-kr
        set fileencoding=euc-kr
    elseif v:lang =~ "^ja_JP"
        set encoding=euc-jp
        set termencoding=euc-jp
        set fileencoding=euc-jp
    endif
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
        set encoding=utf-8
        set termencoding=utf-8
        set fileencoding=utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif


cd E:\MC
 
syntax on

let delimitMate_expand_cr = 1
"" don't use <:>, or can't work with closetag
au FileType html,tpl,php let b:delimitMate_matchpairs = "(:),[:],{:}"

let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.tpl,*.php"

filetype plugin indent on

colorscheme emacsredux.com
" colorscheme darkocean                 

set go-=T
set go-=r
set go-=R
set go-=l
set go-=L
set go-=b
"Toggle tabline Menu and Toolbar
set guioptions-=m
set guioptions-=e
set showtabline=0
" set guifont=DejaVu_Sans_Mono:h9:cANSI
" set guifont=Inconsolata:h9:cANSI
" set guifont=Courier\ New:h9:cANSI
set guifont=Lucida_Console:h9:cANSI
set linespace=1
         
" set tabline=%!MyTabLine()

set mousehide
set cursorline

set autoindent
set softtabstop=4
set shiftwidth=4

" set relativenumber
" set numberwidth=3
set norelativenumber

" 下两行转换所有tab为空格
set expandtab
" :%retab
" 所有非空字符后的制表符不会受到影响。
" 如果你想要转化这些制表符，需要在命令中加入 :%retab!
" 这不大安全。因为它也许会修改字符串内的制表符。要检查这种情况是否存在，可以执行：
" /"[^"\t]*\t[^"]*"

" 空格转化为制表符的命令则恰好相反：
" :set noexpandtab
" :%retab!
 
"状态栏显示参数 Format the status line
"set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c\ \ \ %p%%
set laststatus=2
"let Powerline_symbols="unicode"
"let Powerline_cache_file=""
" Powerline主题已加入 bomb显示

" :w ++ff=dos
" :w ++ff=mac
" :w ++ff=unix
set ff=unix
set fileformats=unix,dos



let NERDChristmasTree=1

"if has("statusline")
" set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
"endif

"taglist只处理当前文件
let Tlist_Show_One_File=1

"Clojure 彩虹
let vimclojure#ParenRainbow = 3                                                                                                                       

let g:Tlist_Use_Right_Window = 1
let g:tlist_php_settings = 'php;c:class;d:constant;f:function'

let g:tabman_toggle = '<leader>mt'
let g:DisableAutoPHPFolding = 1

let g:paredit_electric_return = 0
let g:enable_redl_complete = 0

if mapcheck('<LocalLeader>p')
    " unmap <LocalLeader>p
endif

if has("autocmd")
    au BufReadPost *.cljs set filetype=clojure
    " XXX move to file type plugin
    au BufEnter * noremap <A-/> :call Komment('\/\/')<CR>
    au BufEnter *.erl noremap <silent> <A-/> :call Komment('%%')<CR>
    au BufEnter *.clj noremap <silent> <A-/> :call Komment(';;')<CR>
endif

let s:tmpdir = "c:/tmp/"
if !isdirectory(s:tmpdir)
    call mkdir(s:tmpdir)
endif

let s:tmpdir = "c:/tmp/backup/"
if !isdirectory(s:tmpdir)
    call mkdir(s:tmpdir)
endif

let s:tmpdir = "c:/tmp/swap//"
if !isdirectory(s:tmpdir)
    call mkdir(s:tmpdir)
endif

" http://stackoverflow.com/questions/821902/disabling-swap-files-creation-in-vim
" set nobackup
" set noswapfile
" set backupdir=~/.vim/backup//
set backupdir=c:/tmp/backup//,.
" set directory=.,c:\tmp,c:\temp
" set directory=~/.vim/swap//
set directory=c:/tmp/swap//
" set undodir=~/.vim/undo//
" set undofile
" set undoreload


noremap <A-r> cqp

" TODO: use qa ..., then @a, @@, as temporary key map

" It's 2011.
noremap j gj
noremap k gk
noremap <A-k> 5k
noremap <A-j> 5j

nnoremap <SPACE> gt
nnoremap <S-SPACE> gT

noremap ,u :UndotreeToggle<CR>

nnoremap <silent> <F2> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

nnoremap <silent> <F3> :if &showtabline==0 <Bar>
        \set showtabline=1 <bar>
    \else <Bar>
        \set showtabline=0 <Bar>
    \endif<CR>

" Keep search matches in the middle of the window and pulse the line when moving
" to them.
nnoremap n nzzzv:call PulseCursorLine()<cr>
nnoremap N Nzzzv:call PulseCursorLine()<cr>

nnoremap <silent> <F8> :TlistToggle<CR>
" debug PHP当前
" FIXME: <C-A><C-J> ?
"        :'<,'>!D:\......
nnoremap <C-J> :!E:\wamp\bin\php\php5.3.0\php -l %<CR>
 
nnoremap <silent> <A-/> :call Komment('\/\/')<CR>
vnoremap <silent> <A-/> :call Komment('\/\/')<CR>
nnoremap <silent> ,/ :call KommentMulti()<CR>
vnoremap <silent> ,/ :call KommentMulti()<CR>

" ssh
nnoremap <C-h>1 :!E:\download\putty username@ip -P 26299 -pw ...<CR>
nnoremap <C-h>2 :!E:\download\putty ip -P 26299 -l username<CR> 
" win folder
nnoremap <S-h>1 :silent !explorer.exe D:\program\wamp\www\mandarincafe<CR>
nnoremap <S-h>2 :silent !explorer.exe D:\program\wamp\www\tmus\home\tmus\htdocs<CR>
nnoremap <S-h>mc :silent !explorer.exe D:\program\wamp\www\mandarincafe<CR>
nnoremap <S-h>tm :silent !explorer.exe D:\program\wamp\www\tmus\home\tmus\htdocs<CR>
nnoremap <LocalLeader>1 :silent !explorer.exe D:\program\wamp\www\crm<CR>
nnoremap <LocalLeader>w :call OpenCurrentFileDir()<CR>
nnoremap <LocalLeader>tm :silent !explorer.exe D:\program\wamp\www\tmus\home\tmus\htdocs<CR>
nnoremap <LocalLeader>crm :silent !explorer.exe D:\program\wamp\www\crm<CR>
nnoremap <LocalLeader>mc :silent !explorer.exe D:\program\wamp\www\mandarincafe<CR>

nnoremap ,c :new D:\doc\work<CR> 
nnoremap <C-h>d :new D:\doc\work<CR> 
     
nnoremap <S-l> :call MakLastSea()<CR>
" nnoremap <C-l> :match none<CR>

:highlight SearchMarkGroup ctermbg=blue guibg=blue

" generate doc comment template
nnoremap <LocalLeader>/ :call GenerateDOCComment()<CR>
" nnoremap <LocalLeader>\ /function.*{\c<CR>ggn:call GenerateDOCComment()<CR>
nnoremap <LocalLeader>\ :call BatchGenerateDOCComment()<CR>

nnoremap ,r :new $MYVIMRC<CR>
" FIXME: no work
" nnoremap ,f :NERDTreeClose<CR>
nnoremap ,j :call NERDTreeReopen()<CR>
nnoremap ,n :call NERDTreeTrigger()<CR>
nnoremap <silent> ,m :TlistToggle<CR>
" nnoremap ,s :source D:\doc\mksession<CR>

" nnoremap <LocalLeader>tr :NERDTree<CR>
nnoremap <LocalLeader>t :Tlist<CR>
nnoremap <LocalLeader>f <C-W>s:find<CR>
nnoremap <LocalLeader>r :call GenerateRestrict()<CR>

nnoremap <A-/> :call Komment('\/\/')<CR>

nnoremap <C-M> <C-W><S-+>
nnoremap <C-N> <C-W><S-->
nnoremap <A-m> <C-W>77|
nnoremap <A-n> <C-W>33|
nunmap <S-N>

" noremap ; :                                                                                                                                        
"
" under insert mode can't use :call ..., so <ESC> first
inoremap <C-l> <ESC>:call EchoPhpTagTpl()<CR>
" input text direct
inoremap <C-l> <?php echo $ ?><ESC>2hi

nnoremap <LocalLeader>,g :call FtpGetCurrent()<CR>
nnoremap <LocalLeader>,r :call FtpReplaceCurrent()<CR>
nnoremap <LocalLeader>,d :call FtpDiffCurrent()<CR>
nnoremap <C-h>c :call FtpDiffClose()<CR>
" TODO: add undo, put the ...remote.bak file
nnoremap <LocalLeader>,fff :call FtpPutCurrent()<CR>
nnoremap <LocalLeader>,ttt :call FtpCurrentTab()<CR>
nnoremap <LocalLeader>,aaa :call FtpMultiPutCurrent()<CR>
nnoremap <LocalLeader>,xxx :call FtpMultiCurrentTab()<CR>

let ftpOpts = {'customFtp': 1}
nnoremap <LocalLeader>,cg :call FtpGetCurrent(ftpOpts)<CR>
nnoremap <LocalLeader>,cd :call FtpDiffCurrent(ftpOpts)<CR>
nnoremap <LocalLeader>,cr :call FtpReplaceCurrent(ftpOpts)<CR>
nnoremap <LocalLeader>,cff :call FtpPutCurrent(ftpOpts)<CR>
nnoremap <LocalLeader>,ctt :call FtpCurrentTab(ftpOpts)<CR>

" map H :silent !explorer.exe D:\program\wamp\www\mandarincafe
" vmap Htm :silent !explorer.exe D:\program\wamp\www\tmus\home\tmus\htdocs
" omap Htm :silent !explorer.exe D:\program\wamp\www\tmus\home\tmus\htdocs
" vmap Hmc :silent !explorer.exe D:\program\wamp\www\mandarincafe
" omap Hmc :silent !explorer.exe D:\program\wamp\www\mandarincafe
" vmap H2 :silent !explorer.exe D:\program\wamp\www\tmus\home\tmus\htdocs
" omap H2 :silent !explorer.exe D:\program\wamp\www\tmus\home\tmus\htdocs
" vmap H1 :silent !explorer.exe D:\program\wamp\www\mandarincafe
" omap H1 :silent !explorer.exe D:\program\wamp\www\mandarincafe
" nnoremap Htm :silent !explorer.exe D:\program\wamp\www\tmus\home\tmus\htdocs
" nnoremap Hmc :silent !explorer.exe D:\program\wamp\www\mandarincafe
" nnoremap H2 :silent !explorer.exe D:\program\wamp\www\tmus\home\tmus\htdocs
" nnoremap H1 :silent !explorer.exe D:\program\wamp\www\mandarincafe 

nnoremap <C-K> :call SetLastTab()<CR>
nnoremap <C-L> :call ToLastTab()<CR>
nnoremap ,t :call SetTabSets()<CR>
nnoremap ,s :call ClearTabSets()<CR>
nnoremap <A-a> :call ToTabSets()<CR>
nnoremap <A-z> :call ToTabSets('prev')<CR>

nnoremap <LocalLeader>nc :call NewTabCurFile()<CR>
nnoremap <LocalLeader>nn :call NextTabCurFile()<CR>
nnoremap <LocalLeader>pc :call PrevNewTabCurFile()<CR>
nnoremap <LocalLeader>pp :call PrevTabCurFile()<CR>

nnoremap <C-g> :call IncFont()<CR>
" nnoremap <C-h> :call DecFont()<CR>

nnoremap <C-W>c <C-W>c<C-W>_
 
" XXX: manual exec, or all erl may insert this
nnoremap <LocalLeader>ec :call InsertTpl('E:/doc/Erlang/zotonic-release-0.12.1/tpl.erl')<CR>
" au BufNewFile,BufReadPost *.erl call InsertTpl('E:/doc/Erlang/zotonic-release-0.12.1/tpl.erl')

vmap <silent> <expr> p <sid>Repl()

" Quickly select text you just pasted:
noremap gV `[v`]

" https://github.com/tpope/vim-rsi/blob/master/plugin/rsi.vim
inoremap <C-A> <C-C>0i
inoremap <C-E> <C-C>$a
" inoremap <C-F> <C-C>la
inoremap <C-F> <right>
" inoremap <C-B> <C-C>ha
inoremap <C-B> <left>
inoremap <C-D> <del>
inoremap <A-f> <C-C>ea
inoremap <A-b> <C-C>bi
" cnoremap <C-A> <C-B>
cnoremap <C-A> <home>
cnoremap <C-B> <left>
cnoremap <A-f> <C-F>
cnoremap <A-b> <left>
" <C-F> original is history window
"       use q: q/ q? in normal
cnoremap <C-F> <right>
cnoremap <C-D> <del>
" XXX vim will block, C-c in cmd window to unblock
nnoremap ,h :!cmd<CR>
" https://github.com/xolox/vim-shell
" https://github.com/xolox/vim-misc
" https://github.com/xolox/vim-notes
" F11 fullscreen
" and background execute
let g:shell_fullscreen_always_on_top = 0


" https://github.com/avelino/vim-bootstrap/tree/master/vim_template
" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv



" :arg *.c 	All *.c files in current directory.
" :set hidden 	Allow switching away from a changed buffer without saving.
" :set autowriteall 	Or, use this for automatic saving (instead of :set hidden).
" ... 	Move cursor to word that is to be replaced.
" :Replace whatever 	Search and replace in all files in arglist; confirm each change.
" :Replace! whatever 	Same, but do not confirm each change.
" :wa 	Write all changed files (not needed if used :set autowriteall). 
command! -nargs=* -bang Replace :call Replace(<bang>0, <f-args>)
" command! -nargs=* -bang Replace :call Replace(<bang>0, <q-args>)
" nnoremap <Leader>r :call Replace(0, input('Replace '.expand('<cword>').' with: '))<CR>

" maximize Vim window
autocmd GUIEnter * simalt ~x 

" au FileType php noremap K :call OpenPhpFunction(expand('<cword>'))<CR>
 
" 即可实现“一旦vim窗口失去焦点，即你切换到其他窗口，vim编辑文件就会自动保存”。
" au FocusLost * :wa

" 如果只想保存被修改的文件，那么上述语句改为：
" au FocusLost * :up

" 错误提示“没有文件名”
au FocusLost * silent! up

" XXX session now all place in $VIM/session/*.sss
"
" XXX this control search by '*'
"     setlocal iskeyword=@,48-57,_,128-167,224-235
"     but in the work session some file is 
"     setlocal iskeyword=@,48-57,_,128-167,224-235,?,-,*,!,+,/,=,<,>,.,:
"     it is not right, use the first line!
function! ResetKeyWord ()
    setlocal iskeyword=@,48-57,_,128-167,224-235
endfunction

" au FileType php,python,c,java,javascript,html,htm,smarty,json setl cursorline   " 高亮当前行
au FileType php,python,c,java,javascript,html,htm,smarty,json setl cursorcolumn " 高亮当前列

au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn

au BufRead,BufNewFile *.fountain set filetype=fountain

" hack in indent/clojure.vim for all macro like def...
" setlocal lispwords+=defmc,defapi,defentity
" this can't work, as the line (if &lispwords =~ w), can fix it but may slow
" setlocal lispwords+=def\\w*

" Alias q if\ winnr('$')>1||tabpagenr('$')>1||confirm('Really\ quit?',\ "&OK\\n&Cancel")==1|quit|endif

" exists("g:confirm_quit") || &cp
"     finish
" endif
" let g:confirm_quit = 1




function! InitTask()
    :silent !D:\tools\putty username@ip -pw "iX^H.ygl~cl1A0t/s*=="
    :silent !"C:\Program Files\Mozilla Firefox\firefox.exe"
    :source D:\doc\mksession
endfunction

function! CleanSessionBuf()
    let fn = 'E:\doc\mksession'
    let fl = readfile(fn, 'b')
    call writefile(filter(fl, 'v:val !~? "badd.*$"'), fn, 'b')
endfunction

function! NERDTreeReopen()
    execute ':NERDTree'
    " \ must in \"" 
    execute ":normal \<C-W>l"
    if empty(getline(1)) && empty(getline(2)) || getline(1) == '" Press ? for help'
    " if getline(1) == '' && getline(2) == ''
        execute ":normal \<C-W>c"
    endif
endfunction

function! NERDTreeTrigger()
    execute ":normal \<C-W>h"
    if getline(1) == '" Press ? for help'
        if winwidth(0) >= 30
            execute ":normal \<C-W>1|"
        else
            execute ":normal \<C-W>33|"
            execute ":normal 0"
        endif
        execute ":normal \<C-W>p"
    endif
endfunction
"==============================================================================
" => Status line
"==============================================================================

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

" :pwd
" .../project/
" 
" auto/ftp.ini
" ; for vim ftp crm
" open 42.120.1.137
" username
" password
" cd rootdir/
function! FtpCurrentDelegate(a, method)
   " argv must be dict opts
   " 变量可能是list: let args = len(a:a) && type(a:a) == type([]) ? a:a[0] : {}
   " 变量类型或数据结构不变可使之后减少检测、错误处理等代码
   let args = len(a:a) && type(a:a) == type([]) ? a:a : [{}]

   " may nested in nest func
   while type(get(args, 0)) == type([])
        let args = args[0]
   endwhile

   let argv = get(args, 0)

   if type(argv) == type({}) && get(argv, 'customFtp') == 1
       let files = filter(split(globpath('auto/', '*'), '\n'), '!isdirectory(v:val) && v:val =~ "ftp.*\.ini$" ')
       let filelist = insert(map(copy(files), ' "<" . v:key . ">" . " " . v:val '), 'Select ftp config file number:')
       return FtpCurrent(a:method, files[inputlist(filelist)])
       " return FtpCurrent(a:method, input('Enter ftp.ini path:', 'auto/ftp.ini', 'file'))
   else
       return FtpCurrent(a:method)
   endif
endfunction

function! FtpGetCurrent(...)
   return FtpCurrentDelegate(a:000, 'get')
endfunction

function! FtpPutCurrent(...)
   if len(a:000) == 0 || input('Backup remote (Y/N)?', 'Y') ==? 'Y'
        call FtpBakRemote(a:000)
   endif
   call FtpCurrentDelegate(a:000, 'put')
endfunction

" Notice: multi site ftp will not bak remote
function! FtpMultiPutCurrent()
   let i = 0
   let file = 'auto/ftp0.ini'
   while filereadable(file)
       call FtpCurrent('put', file)
       let i += 1
       let file = 'auto/ftp' . i . '.ini'
   endwhile
endfunction

function! FtpMultiCurrentTab()
    :windo call FtpMultiPutCurrent()
endfunction

function! FtpBakCurrent()
   let localfile = expand('%:p:f')
   let fl = readfile(localfile, 'b')
   call writefile(fl, localfile . '.bak', 'b')
endfunction

function! FtpBakRemote(...)
   let localfile = expand('%:p:f')
   let tmpRemoteFile = FtpGetCurrent(a:000).tmpRemoteFile
   let fl = readfile(tmpRemoteFile, 'b')
   call writefile(fl, localfile . '.remote.bak', 'b')
   call delete(tmpRemoteFile)
endfunction

function! FtpReplaceCurrent(...)
   call FtpBakCurrent()
   let localfile = expand('%:p:f')
   let tmpRemoteFile = FtpGetCurrent(a:000).tmpRemoteFile
   let fl = readfile(tmpRemoteFile, 'b')
   call writefile(fl, localfile, 'b')
   call delete(tmpRemoteFile)
endfunction

function! FtpDiffCurrent(...)
   " let filename = expand('%:t')
   " for FtpDiffClose to back
   normal ml
   let localfile = expand('%:p:f')
   let tmpRemoteFile = FtpGetCurrent(a:000).tmpRemoteFile
   " let tmpDiffFile = './auto/tmp.local.' . filename

   " can't open new vimdiff current file, copy it
   " let fl = readfile(localfile, 'b')
   " call writefile(fl, tmpDiffFile, 'b')

   execute ':tabnew ' . localfile
   execute ':vertical diffsplit ' . tmpRemoteFile
   windo set wrap
   " execute ':!vimdiff ' . tmpDiffFile . ' ' . tmpRemoteFile

   " call delete(tmpDiffFile)
   call delete(tmpRemoteFile)
endfunction

function! FtpDiffClose()
    q
    q
    tabprev
    " mark in FtpDiffCurrent
    normal 'lzz
endfunction

function! FtpCurrentTab(...)
    windo call FtpPutCurrent(a:000)
endfunction

function! FtpCurrent(act, ...)
    let debug = 0
    let cwd = getcwd()
    let ftpCmdFile = len(a:000) > 0 ? a:1 : 'auto/ftp.ini'
    let localfile = expand('%:p:f')
    let filename = expand('%:t')
    let toremote = expand('%:h')

    if localfile == ''
        return
    endif

    let dir = '.\'
    let arr = split(toremote, '\')
    " let arr = split(toremote, '\')[:-2];

    " under windows, dir by expand lost case info, use globpath repair it
    for i in arr                                                                    
        let subdir = filter(split(globpath(dir, '*'), '\n'), 'isdirectory(v:val)')  
                                                                                    
        if debug == 1
            echo 0
            echo subdir
            echo 1
            echo dir . i
        endif

        for j in subdir                                                             
            if (dir . i) ==? j                                                         
                " use real dir name                                                 
                let toremote = j                                                    
                let dir = j . '\'
                if debug == 1
                    echo 3
                    echo dir
                endif                                                                   
                break                                                               
            endif                                                                   
        endfor                                                                      
    endfor                                                                          
                                                                                    
    " execute ':cd ' . cwd                                                            
                                                                                    
    let toremote = substitute(toremote, '\', '/', 'g')
    " for dos
    " let tmpRemoteFile = './auto/tmp.' . filename
    " for winscp
    let tmpRemoteFile = '.\auto\tmp.' . filename

    if a:act == 'get'
        let ftpCmd = 'get ' . toremote . '/' . filename . ' ' . tmpRemoteFile
    else
        let ftpCmd = 'put ' . localfile . ' ' . toremote . '/' . filename
    endif
    
    let fl = readfile(ftpCmdFile, 'b')
    call writefile(fl + [ftpCmd, 'close', 'exit'], ftpCmdFile, 'b')
    
    " dos ftp can't work some times
    execute ':silent !E:/download/winscp571/winscp.com /script=' . ftpCmdFile
    
    call writefile(fl, ftpCmdFile, 'b')

    return {'tmpRemoteFile': tmpRemoteFile}
endfunction

function! FtpCurrent2(act, ...)
    let debug = 0
    let cwd = getcwd()
    let ftpCmdFile = len(a:000) > 0 ? a:1 : 'auto/ftp.ini'
    let localfile = expand('%:p:f')
    let filename = expand('%:t')
    let toremote = expand('%:h')

    if localfile == ''
        return
    endif

    let dir = '.\'
    let arr = split(toremote, '\')
    " let arr = split(toremote, '\')[:-2];

    " under windows, dir by expand lost case info, use globpath repair it
    for i in arr                                                                    
        let subdir = filter(split(globpath(dir, '*'), '\n'), 'isdirectory(v:val)')  
                                                                                    
        if debug == 1
            echo 0
            echo subdir
            echo 1
            echo dir . i
        endif

        for j in subdir                                                             
            if (dir . i) ==? j                                                         
                " use real dir name                                                 
                let toremote = j                                                    
                let dir = j . '\'
                if debug == 1
                    echo 3
                    echo dir
                endif                                                                   
                break                                                               
            endif                                                                   
        endfor                                                                      
    endfor                                                                          
                                                                                    
    " execute ':cd ' . cwd                                                            
                                                                                    
    let toremote = substitute(toremote, '\', '/', 'g')
    let tmpRemoteFile = './auto/tmp.' . filename

    if a:act == 'get'
        let ftpCmd = 'get ' . toremote . '/' . filename . ' ' . tmpRemoteFile
    else
        let ftpCmd = 'put ' . localfile . ' ' . toremote . '/' . filename
    endif
    
    let fl = readfile(ftpCmdFile, 'b')
    call writefile(fl + [ftpCmd, 'quit'], ftpCmdFile, 'b')
    
    execute ':!ftp -s:' . ftpCmdFile
    
    call writefile(fl, ftpCmdFile, 'b')

    return {'tmpRemoteFile': tmpRemoteFile}
endfunction

let s:lastTab = 0
function! SetLastTab()
    let s:lastTab = tabpagenr()
endfunction
function! ToLastTab()
    let toTab = s:lastTab
    call SetLastTab()
    :tabfirst
    execute ':' . toTab .'tabnext'
endfunction

let s:curTabSet = 0
let s:tabSetSum = 0

function! ClearTabSets()
    let i = 0
    while exists('s:tabSetCnt' . i)
        unlet s:tabSetCnt{i}
        let i = i + 1
    endwhile
    let s:tabSetSum = 0
endfunction

function! SetTabSets()
    let i = 0
    while exists('s:tabSetCnt' . i)
        let i = i + 1
    endwhile

    let s:tabSetCnt{i} = tabpagenr()
    let s:tabSetSum = i
endfunction

function! ToTabSets(...)
    function! l:to()
        :tabfirst
        execute ':' . s:tabSetCnt{s:curTabSet} .'tabnext'
    endfunction

    if !exists('s:tabSetCnt0')
        return
    endif

    if len(a:000) == 0 || a:1 ==? 'next'
        let op = '+'
    else
        let op = '-'
    endif

    if !exists('s:tabSetCnt' . s:curTabSet)
        if op == '+'
            let s:curTabSet = 0
        else
            let s:curTabSet = s:tabSetSum
        endif
    endif
    call l:to()
    execute "let s:curTabSet = s:curTabSet " . op . " 1"
endfunction   

function! FindLongerLines()
    let @/ = '^.\{' . col('$') . '}'
    silent! norm n$
endfunction

function! CursorPing()
    " http://briancarper.net/blog/590/cursorcolumn--cursorline-slowdown
    set cursorline cursorcolumn
    redraw
    sleep 50m
    set nocursorline nocursorcolumn
endfunction

" nmap <C-Space> :call CursorPing()<CR>


" ';;'
" '%%'
" '\/\/'
function! Komment(cmt)
  let text = getline(".")

  if text =~ '^\s*' . a:cmt || text =~ '^' . a:cmt
    exec 's/^\(\s*\)' . a:cmt . '\s\{0,1}/\1/'
    " s/^\(\s*\)\/\/\s\{0,1}/\1/            
    " let hls=@/
    " s/^\/\///
    " let @/=hls
   " elseif text =~ '^\(\s*\)\(\S\)'
   else
    exec 's/^\(\s*\)\(\S*\)/\1' . a:cmt . ' \2/'
    " s/^\(\s*\)\(\S*\)/\1\/\/ \2/            
    " let hls=@/
    " s/^/\/\//
    " let @/=hls
    normal 2la
  endif

endfunction

function! KommentMulti()
  let text = getline(".")

  if text =~ '^\s*\/\*' || text =~ '^\/\*'
    s/^\(\s*\)\/\/\s\{0,1}/\1/            
    " let hls=@/
    " s/^\/\///
    " let @/=hls
   else
    s/^\(\s*\)\(\S*\)/\1\/\* \2/            
    s/\(.*\)$/\1 \*\//            
    " let hls=@/
    " s/^/\/\//
    " let @/=hls
    normal 2la
  endif

endfunction

function! KommentV()

  let l    = line('.')
  let text = getline(l-1)

endfunction      

function! OpenCurrentFileDir()
    let dir = expand('%:h')
    execute ':silent !C:\windows\explorer.exe ' . dir
endfunction

" TODO: How to get last search string or current highlight string 
" set a / tag to preserve last highlight
function! MakLastSea()
    let last = @/
    execute ':match SearchMarkGroup /' . last '/'
endfunction

" Pulse ------------------------------------------------------------------- {{{
function! PulseCursorLine()
    let current_window = winnr()

    windo set nocursorline
    execute current_window . 'wincmd w'

    setlocal cursorline

    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    hi CursorLine guibg=#2a2a2a ctermbg=233
    redraw
    sleep 20m

    hi CursorLine guibg=#333333 ctermbg=235
    redraw
    sleep 20m

    hi CursorLine guibg=#3a3a3a ctermbg=237
    redraw
    sleep 20m

    hi CursorLine guibg=#444444 ctermbg=239
    redraw
    sleep 20m

    hi CursorLine guibg=#3a3a3a ctermbg=237
    redraw
    sleep 20m

    hi CursorLine guibg=#333333 ctermbg=235
    redraw
    sleep 20m

    hi CursorLine guibg=#2a2a2a ctermbg=233
    redraw
    sleep 20m

    execute 'hi ' . old_hi

    windo set cursorline
    execute current_window . 'wincmd w'
endfunction

" }}}

" generate for $countryName = $stuent->getCountry()->getName();
" if (!($tmp = $student->getCountry())) {
"     return false;
" }
function! GenerateRestrict()
    let l = line('.')
    let i = indent(l)
    let pre  = repeat(' ',i)
    let text = getline(l)
    let var = matchstr(text,'($[^=])\s*=\s*')
    let method = matchstr(text,'$[^=)]*(.*)')

    let block = [pre . 'if (!($tmp = ' . method . ')) {']
    if var =~ ''
        let block  += [pre . '    return false; ']
    else
        let block  = [pre . var . ' = '';'] + block 
        let block  += [pre . '    ' . var . ' = $tmp->']
    endif
    let block  += [pre . '} ']

    call append(l-1, block)
    call cursor(l, i+8)
endfunction

function! BatchGenerateDOCComment()
  function! l:next()
      " let line = search('...')
      " q/ to get [[ history
      /\(.*\%#\)\@!\_^\s*\zs\(\(abstract\s\+\|final\s\+\|private\s\+\|protected\s\+\|public\s\+\|static\s\+\)*function\|\(abstract\s\+\|final\s\+\)*class\|interface\)
  endfunction

  normal mo

  call cursor(1, 1)
  call l:next()
  call GenerateDOCComment()

  call l:next()
  let firstMatLine = line('.')

  call l:next()
  while line('.') > firstMatLine    
       call GenerateDOCComment()    
       call l:next()
       normal j
       call l:next()                
  endwhile                          

  normal 'o
  " let line = search('')
  " q/ to get [[ history
"   /\(.*\%#\)\@!\_^\s*\zs\(\(abstract\s\+\|final\s\+\|private\s\+\|protected\s\+\|public\s\+\|static\s\+\)*function\|\(abstract\s\+\|final\s\+\)*class\|interface\)
"   execute \":normal gg"
" 
"   execute \"n"
"   let firstMatLine = line('.')
" 
"   call GenerateDOCComment()
" 
"   execute "n"
"   while line('.') > firstMatLine
"       call GenerateDOCComment()
"       execute "n"
"   endwhile

endfunction

function! GenerateDOCComment()
  let l    = line('.')
  let i    = indent(l)
  let pre  = repeat(' ',i)
  let text = getline(l)
  let params = matchstr(text,'([^)]*)')[1:-2]

  let vars = []
  let paramsArr = split(params, ',')
  let paramsArr = map(paramsArr, 'split(v:val, "=")')

  function! l:trim(str)
      return substitute(a:str, '^ \| $', '', 'g') 
  endfunction

  for arr in paramsArr
      let key = l:trim(arr[0])
      if len(arr) == 2
          let key = key .  ' DEFAULT ' .  l:trim(arr[1]) 
      endif 
      let vars += [pre.' * @param '. key]
  endfor


"   let paramPat = '\([$a-zA-Z_0-9]\+\)[, ]*\(.*\)'
"   echomsg params
"   let m    = ' '
"   let ml = matchlist(params,paramPat)
"   while ml!=[]
"     let [_,var;rest]= ml
"     let vars += [pre.' * @param '.var]
"     let ml = matchlist(rest,paramPat,0)
"   endwhile

  let vars += [pre.' * @return ']
  let comment = [pre.'/**',pre.' * '] + vars + [pre.' */']
  call append(l-1,comment)
  call cursor(l+1,i+3)
endfunction

" hell where TAB is nnoremaped?
" inoremap <TAB> <TAB>

function! EchoPhpTagTpl ()
    let l = line('.')
    let tx = getline(l)
    let pos = col(l)
    let tpl = 'php echo '

    echomsg strpart(tx, pos - 2, 2)

    if strpart(tx, pos - 2, 2) =~ '<?'
        let str = strpart(tx, 0, pos) + tpl + '?>' + strpart(tx, pos + 2)
        call setline(l, str)
        call cursor(l, pos + strlen(tpl))
    endif
endfunction

" You need links browser to make it work.
function! OpenPhpFunction (keyword)

  let proc_keyword = substitute(a:keyword , '_', '-', 'g')

  exe '5 split'

  exe 'enew'

  exe 'set buftype=nofile'

  " no gui browser include firefox can dump url?
  exe 'silent r!"c:\Program Files\Mozilla Firefox\firefox.exe" -dump http://www.php.net/manual/en/print/function.'.proc_keyword.'.php'
  "exe 'silent r!links -dump http://www.php.net/manual/en/print/function.'.proc_keyword.'.php'

  exe 'norm gg'

  exe 'call search ("Description")'

  exe 'norm jdgg'

  exe 'call search("User Contributed Notes")'

  exe 'norm dGgg'

  exe 'norm V'

endfunction

function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" Search for current word and replace with given text for files in arglist.
" http://vim.wikia.com/wiki/Search_and_replace_in_multiple_buffers
function! Replace(bang, pat)
  let flag = 'e'
  if !a:bang
    let flag .= 'c'
  endif
  " let search = '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
  " let replace = escape(a:replace, '/\&~')
  execute 'argdo ' . a:pat . flag
endfunction

function! SearchCrm(bang, pat)
    execute 'vimgrep ' . a:pat 'apps/**/*.php plugins/**/*.php lib/*.php lib/form/doctrine/*.php lib/form/doctrine/**/*.php lib/filter/doctrine/*.php lib/filter/doctrine/**/*.php lib/model/doctrine/*.php lib/model/doctrine/**/*.php lib/contract/*.php  lib/task/*.php lib/uc_client/*.php lib/uc_client/**/*.php lib/validator/*.php '
endfunction

function! NewTabCurFile()
    normal mo
    execute 'tabnew ' . expand('%:p')
    tabprev
    normal 'o
endfunction

function! NextTabCurFile()
    normal mo
    let curFile = expand('%:p')
    tabnext
    execute 'new ' . curFile
    tabprev
    normal 'o
endfunction
 
function! PrevNewTabCurFile()
    normal mo
    let curFile = expand('%:p')
    tabprev
    execute 'tabnew ' . curFile
    tabnext
    normal 'o
endfunction

function! PrevTabCurFile()
    normal mo
    let curFile = expand('%:p')
    tabprev
    execute 'new ' . curFile
    tabnext
    normal 'o
endfunction

function! __tpl(str, tag, v)
    return substitute(a:str, "{{" .a:tag. "}}", a:v, "")
endfunction

function! InsertTpl(tpl)
    if -1 == stridx(getline(1), '%% @author ') 
                \ && -1 == stridx(getline(2), '%% @author ') 
                \ && -1 == stridx(getline(3), '%% @author ')
        " :read(a:tpl)
        let fn = expand("%:t:r")
        let str = join(readfile(a:tpl), "\n")
        let str = __tpl(str, "year", strftime("%Y"))
        let str = __tpl(str, "date", strftime("%Y-%m-%d"))
        let str = __tpl(str, "mod_name", fn)
        let lst = split(str, "\n")
        if filereadable(expand("%:p"))
            let lst = lst + readfile(expand("%:p"))
        endif
        normal ggO
        call setline(1, lst)
        normal G
    endif
endfunction

let $in_hex=0
function! HexMe()
    set binary
    set noeol
    if $in_hex>0
        :%!xxd -r
        let $in_hex=0
    else
        :%!xxd
        let $in_hex=1
    endif
endfunction

" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
 
let s:curFontSize = 9
function! IncFont()
    let s:curFontSize += 1
    :call ChgFont()
endfunction
function! DecFont()
    let s:curFontSize -= 1
    :call ChgFont()
endfunction
function! ChgFont()
    " :exec \":set guifont=Courier\\ New:h" .s:curFontSize. \":cANSI"
    :exec ":set guifont=Lucida_Console:h" .s:curFontSize. ":cANSI"
endfunction
