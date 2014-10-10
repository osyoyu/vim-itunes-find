let s:save_cpo = &cpo
set cpo&vim

let s:script_dir = expand('<sfile>:p:h')

function! s:find_and_play_all(...)
  let s:find_string = join(a:000, " ")
  call system("osascript " . s:script_dir . "/itunes.applescript \"" . s:find_string . "\" 1")
endfunction

function! s:find_and_play_one(...)
  let s:find_string = join(a:000, " ")
  call system("osascript " . s:script_dir . "/itunes.applescript \"" . s:find_string . "\" 2")
endfunction

function! s:find_and_play_album(...)
  let s:find_string = join(a:000, " ")
  call system("osascript " . s:script_dir . "/itunes.applescript \"" . s:find_string . "\" 3")
endfunction

command! -nargs=+ PlayAll call s:find_and_play_all(<f-args>)
command! -nargs=+ PlayTrack call s:find_and_play_one(<f-args>)
command! -nargs=+ PlayAlbum call s:find_and_play_album(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo
