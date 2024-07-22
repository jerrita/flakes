{...}: {
  services.yabai = {
    enable = true;
    config = {
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
      window_placement = "second_child";
      window_opacity = "off";

      layout = "bsp";
      top_padding = 10; # 36
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 10;
    };
    extraConfig = ''
      yabai -m rule --add app='^System Preferences$' manage=off
      yabai -m rule --add app="^Archive Utility$" manage=off
      yabai -m rule --add app="^QQ$" manage=off
      yabai -m rule --add app="^WeChat$" manage=off
    '';
  };
}
