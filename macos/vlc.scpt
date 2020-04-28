-- https://github.com/jeroenbegyn/VLCControl

on run argv
  if count of argv is equal to 0 then
    set msg to "Use the following commands:\n"
    set msg to msg & "  info               - Print track info\n"
    set msg to msg & "  duration           - Print track duration\n"
    set msg to msg & "  playpause          - Play / Pause\n"
    set msg to msg & "  next               - Next track\n"
    set msg to msg & "  previous, prev     - Previous track\n"
    set msg to msg & "  forward N          - Jump N seconds forwards\n"
    set msg to msg & "  rewind N           - Jump N seconds backwards"
    return msg
  end if
  set command to item 1 of argv
  using terms from application "VLC"
    set info to "Error."

    if command is equal to "info" then
      tell application "VLC"
        set tM to round (duration of current item / 60) rounding down
        set tS to duration of current item mod 60
        set myTime to tM as text & "min " & tS as text & "s"
        set nM to round (current time / 60) rounding down
        set nS to round (current time mod 60) rounding down
        set nowAt to nM as text & "min " & nS as text & "s"
        set info to "Current track:"
        set info to info & "\n Item:   " & name of current item
        set info to info & "\n Duration: " & mytime & " ("& duration of current item & " seconds)"
        set info to info & "\n Now at:   " & nowAt
      end tell
      return info

    else if command is equal to "duration" then
      set info to "Error."
      tell application "VLC"
        set info to duration of current item
      end tell
      return info

    else if command is equal to "playpause" or command is equal "play" or command is equal "pause" then
      tell application "VLC" to play

    else if command is equal to "next" then
      tell application "VLC" to next

    else if command is equal to "previous" or command is equal to "prev" then
      tell application "VLC" to previous

    else if command is equal to "forward"
      set jump to item 2 of argv as real
      tell application "VLC"
        set now to current time
        set tMax to duration of current item
        set jumpTo to now + jump
        if jumpTo > tMax
          return "Can't jump past end of track."
        else if jumpTo < 0
          set jumpTo to 0
        end if
        set nM to round (jumpTo / 60) rounding down
        set nS to round (jumpTo mod 60) rounding down
        set newTime to nM as text & "min " & nS as text & "s"
        set current time to jumpTo
        return "Jumped to " & newTime
      end tell

    else if command is equal to "rewind"
      set jump to item 2 of argv as real
      tell application "VLC"
        set now to current time
        set tMax to duration of current item
        set jumpTo to now - jump
        if jumpTo > tMax
          return "Can't jump past end of track."
        else if jumpTo < 0
          set jumpTo to 0
        end if
        set nM to round (jumpTo / 60) rounding down
        set nS to round (jumpTo mod 60) rounding down
        set newTime to nM as text & "min " & nS as text & "s"
        set current time to jumpTo
        return "Jumped to " & newTime
      end tell
    end if
  end using terms from
end run
