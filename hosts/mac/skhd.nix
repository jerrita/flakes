{...}: {
  services.skhd = {
    enable = true;
    skhdConfig = ''
      cmd - return : open -n -a iTerm
      cmd + shift - return : open -n -a Safari

      # window focus
      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - l : yabai -m window --focus east

      # window swap
      shift + alt - h : yabai -m window --swap west
      shift + alt - j : yabai -m window --swap south
      shift + alt - k : yabai -m window --swap north
      shift + alt - l : yabai -m window --swap east

      # window move
      shift + alt + ctrl - h : yabai -m window --warp west
      shift + alt + ctrl - h : yabai -m window --warp south
      shift + alt + ctrl - h : yabai -m window --warp north
      shift + alt + ctrl - h : yabai -m window --warp east

      # shift + alt - 1: yabai -m window --space 1; yabai -m space --focus 1
      # shift + alt - 2: yabai -m window --space 2; yabai -m space --focus 2
      # shift + alt - 3: yabai -m window --space 3; yabai -m space --focus 3
      # shift + alt - 4: yabai -m window --space 4; yabai -m space --focus 4
      # shift + alt - 5: yabai -m window --space 5; yabai -m space --focus 5
      # shift + alt - 6: yabai -m window --space 6; yabai -m space --focus 6
      # shift + alt - 7: yabai -m window --space 7; yabai -m space --focus 7
      # shift + alt - 8: yabai -m window --space 8; yabai -m space --focus 8
      # shift + alt - 9: yabai -m window --space 9; yabai -m space --focus 9

      # With SIP
      shift + alt - 1: yabai -m window --space 1; skhd -k 'ctrl - 1'
      shift + alt - 2: yabai -m window --space 2; skhd -k 'ctrl - 2'
      shift + alt - 3: yabai -m window --space 3; skhd -k 'ctrl - 3'
      shift + alt - 4: yabai -m window --space 4; skhd -k 'ctrl - 4'
      shift + alt - 5: yabai -m window --space 5; skhd -k 'ctrl - 5'
      shift + alt - 6: yabai -m window --space 6; skhd -k 'ctrl - 6'
      shift + alt - 7: yabai -m window --space 7; skhd -k 'ctrl - 7'
      shift + alt - 8: yabai -m window --space 8; skhd -k 'ctrl - 8'
      shift + alt - 9: yabai -m window --space 9; skhd -k 'ctrl - 9'

      # alt - 1 : yabai -m space --focus 1
      # alt - 2 : yabai -m space --focus 2
      # alt - 3 : yabai -m space --focus 3
      # alt - 4 : yabai -m space --focus 4
      # alt - 5 : yabai -m space --focus 5
      # alt - 6 : yabai -m space --focus 6
      # alt - 7 : yabai -m space --focus 7
      # alt - 8 : yabai -m space --focus 8
      # alt - 9 : yabai -m space --focus 9

      # With SIP
      alt - 1 : skhd -k 'ctrl - 1'
      alt - 2 : skhd -k 'ctrl - 2'
      alt - 3 : skhd -k 'ctrl - 3'
      alt - 4 : skhd -k 'ctrl - 4'
      alt - 5 : skhd -k 'ctrl - 5'
      alt - 6 : skhd -k 'ctrl - 6'
      alt - 7 : skhd -k 'ctrl - 7'
      alt - 8 : skhd -k 'ctrl - 8'
      alt - 9 : skhd -k 'ctrl - 9'

      # increase window size
      shift + alt - w : yabai -m window --resize top:0:-20
      shift + alt - d : yabai -m window --resize left:-20:0

      # decrease window size
      shift + alt - s : yabai -m window --resize bottom:0:-20
      shift + alt - a : yabai -m window --resize top:0:20

      # utils
      alt - r : yabai -m space --rotate 90
      alt - f : yabai -m window --toggle zoom-fullscreen
      alt - g : yabai -m space --toggle padding; yabai -m space --toggle gap
      shift + alt - 0 : yabai -m space --balance

      # float
      alt - space : yabai -m window --toggle float;\
          yabai -m window --toggle border

      alt - d : yabai -m space --layout $(yabai -m query --spaces --space | jq -r 'if .type == "bsp" then "stack" else "bsp" end')
    '';
  };
}
