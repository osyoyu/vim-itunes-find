on run argv
  tell application "iTunes"
    set plname to "PlayQueue"
    set keyword to first item of argv
    
    
    -- prepare a play queue playlist (since we can't control Up Next from AppleScript)
    if not (exists playlist plname) then
      make new user playlist with properties {name:plname}
    end if
    delete every track of user playlist plname
    
    (*
      mode 1: play all tracks which matches keyword (default)
      mode 2: play first track which matches keyword
      mode 3: play the album from the track found in mode 2
    *)
    
    try
      if second item of argv is "1" then
        set results to (every file track of library playlist 1 whose name contains keyword or artist contains keyword or album contains keyword)
        repeat with t in results
          duplicate t to user playlist plname
        end repeat
        
        play user playlist plname
      end if
      
      if second item of argv is "2" then
        set results to {(first file track of library playlist 1 whose name contains keyword or artist contains keyword or album contains keyword)}
        repeat with t in results
          duplicate t to user playlist plname
        end repeat
        
        play user playlist plname
      end if
      
      if second item of argv is "3" then
        set first_track to (first file track of library playlist 1 whose name contains keyword or artist contains keyword or album contains keyword)
        set album_name to album of first_track
        set results to (every file track of library playlist 1 whose album is album_name)
        
        repeat with t in results
          duplicate t to user playlist plname
        end repeat
        
        play user playlist plname
        
        repeat with t in results
          if name of t is name of first_track then
            exit repeat
          end if
          
          next track
        end repeat
      end if
    on error
      set results to (every file track of library playlist 1 whose name contains keyword)
      
      repeat with t in results
        duplicate t to user playlist plname
      end repeat
      
      play user playlist plname
    end try
  end tell
end run
