" =============================================================================
" Plugin Name: vim-rbrun
" Author:      Sinésio 'sineto' Neto <sinetoami [at] gmail [dot] com>
" Version:     0.0.5 - 2018 May 03
" License:     Distributed under the terms of the Vim license.
" Description: A simple plugin to run Ruby code in Vim
" =============================================================================
if exists("g:loaded_rbrun")
  finish
endif
let g:loaded_rbrun = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:rbrun_strategy")
  let g:rbrun_strategy = "basic"
endif

if !exists("g:rbrun_enable_mappings")
  let g:rbrun_enable_mappings = 1
endif

function! s:rbrun_cmd(command)
  if g:rbrun_strategy == "basic"
    echo system(a:command)
  elseif g:rbrun_strategy == "vimux" && exists('*VimuxRunCommand')
    call VimuxRunCommand("clear")
    call VimuxRunCommand(a:command)
    sleep 1300m " take time if Vimux is running
  endif
endfunction

function! s:rbrun_script()
  return s:rbrun_cmd("ruby -w " . expand('%p:t'))
endfunction

" ISSUE: When use 'vimux' strategy the last character of the string line is repeated, ex:
" In the line: ruby -e "(1..10).each { |num| puts num * 2 }";
" the --> }" <-- is repeated.
" And the output will been like: ruby -e "(1..10).each { |num| puts num * 2 }" }".
" I don't know why yet... find a workaround.
function! s:rbrun_line()
  let getline = getline(line('.'))
  let line_around_quotes = "\"" . getline . "\""
  return s:rbrun_cmd("ruby -e " . line_around_quotes)
endfunction

function! s:rbrun_codeblock() range
  let file = tempname()
  silent execute ":'<,'>w " . file
  call s:rbrun_cmd("ruby -w " . file)
  silent execute "!rm -rf " . file
endfunction

function! s:rbrun_paste_output(vimmode) range
  if a:vimmode == 'v'
    execute ":'<,'>!ruby -w"
  elseif a:vimmode == 'n'
    execute ":.!ruby -w"
  endif
endfunction

let s:rbrun_maps = {
      \'RunScript': '<A-e>',
      \'RunLine': '<C-x>',
      \'RunCodeBlock':'<C-x>',
      \'PasteOutputLine':'<C-A-x>',
      \'PasteOutputBlock':'<C-A-x>',
      \}

function! s:rbrun_maps.sub(dict)
  for gkey in keys(a:dict)
    if has_key(self, gkey)
      let self[gkey] = a:dict[gkey]
    endif
  endfor
endfunction

function! s:keymap(type,key,plug)
  return 'autocmd FileType ruby ' . a:type . ' <buffer> ' . a:key . ' <Plug>' . a:plug
endfunction

if exists("g:rbrun_maps")
  call s:rbrun_maps.sub(g:rbrun_maps)
endif

nnoremap <silent> <Plug>RbRunScript           :call <sid>rbrun_script()<CR>
nnoremap <silent> <Plug>RbRunLine             :call <sid>rbrun_line()<CR>
nnoremap <silent> <Plug>RbRunPasteOutputLine  :call <sid>rbrun_paste_output('n')<CR>
vnoremap <silent> <Plug>RbRunCodeBlock        :call <sid>rbrun_codeblock()<CR>
vnoremap <silent> <Plug>RbRunPasteOutputBlock :call <sid>rbrun_paste_output('v')<CR>

augroup VimRbRum
  autocmd!
  if g:rbrun_enable_mappings
    execute s:keymap('nmap', s:rbrun_maps['RunScript'], 'RbRunScript')
    execute s:keymap('nmap', s:rbrun_maps['RunLine'], 'RbRunLine')
    execute s:keymap('vmap', s:rbrun_maps['RunCodeBlock'], 'RbRunCodeBlock')
    execute s:keymap('nmap', s:rbrun_maps['PasteOutputLine'], 'RbRunPasteOutputLine')
    execute s:keymap('vmap', s:rbrun_maps['PasteOutputBlock'], 'RbRunPasteOutputBlock')
  endif
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set ft=vim ff=unix ts=4 sw=2 sts=2:
