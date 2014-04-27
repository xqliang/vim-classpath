" classpath.vim - Set 'path' from the Java class path
" Maintainer:   Tim Pope <http://tpo.pe/>

if exists("g:loaded_classpath") || v:version < 700 || &cp
  finish
endif
let g:loaded_classpath = 1

augroup classpath
  autocmd!
  autocmd BufEnter *.java let g:vjde_lib_path=classpath#from_vim(classpath#detect())
  autocmd FileType clojure,groovy,java,scala
        \ if expand('%:p') =~# '^zipfile:' |
        \   let &l:path = getbufvar('#', '&path') |
        \ else |
        \   let &l:path = classpath#detect() |
        \ endif |
        \ command! -buffer -nargs=+ -complete=file Java execute '!'.classpath#java_cmd().' '.<q-args>
  autocmd FileType clojure,groovy,java,scala
        \ if expand('%:p') =~# '^zipfile:' |
        \   let &l:path = getbufvar('#', '&path') |
        \   let g:classpath_out = '' |
        \   let g:classpath_src = '' |
        \ else |
        \   let &l:path = classpath#detect() |
        \   let g:classpath_out = classpath#detect_out() |
        \   let g:classpath_src = classpath#detect_src() |
        \ endif |
        \ command! -buffer -nargs=+ -complete=file Javac execute '!'.classpath#javac_cmd().' '.<q-args>
augroup END

" vim:set et sw=2:
