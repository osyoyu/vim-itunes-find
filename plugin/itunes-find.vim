let s:save_cpo = &cpo
set cpo&vim

let s:script_dir = expand('<sfile>:p:h')

function! s:find_and_play_all(title)
  call system("osascript " . s:script_dir . "/itunes.applescript " . a:title . " 1")
endfunction

function! s:find_and_play_one(title)
  call system("osascript " . s:script_dir . "/itunes.applescript " . a:title . " 2")
endfunction

function! s:find_and_play_album(title)
  call system("osascript " . s:script_dir . "/itunes.applescript " . a:title . " 3")
endfunction

command! -nargs=1 PlayAll call s:find_and_play_all(<f-args>)
command! -nargs=1 PlayTrack call s:find_and_play_one(<f-args>)
command! -nargs=1 PlayAlbum call s:find_and_play_album(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo
