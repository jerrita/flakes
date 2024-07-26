{...}: {
  services.yabai = {
    enable = true;
    enableScriptingAddition = false;
    config = {
      focus_follows_mouse = "autoraise"; # autoraise / off
      mouse_follows_focus = "off";
      window_placement = "second_child";
      window_opacity = "off";

      layout = "bsp";
      top_padding = 42;
      bottom_padding = 8;
      left_padding = 8;
      right_padding = 8;
      window_gap = 8;
    };

    extraConfig = ''
      # yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

      yabai -m rule --add app="^系统设置$" manage=off
      yabai -m rule --add app="^系统偏好设置$" manage=off
      yabai -m rule --add app="^活动监视器$" manage=off
      yabai -m rule --add app="^提醒事项$" manage=off
      yabai -m rule --add app="^关于本机$" manage=off

      yabai -m rule --add app="^QQ$" manage=off
      yabai -m rule --add app="^微信$" manage=off
      yabai -m rule --add app="^Archive Utility$" manage=off

      # signal with sketchybar
      yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"
      yabai -m signal --add event=window_created action="sketchybar --trigger windows_on_spaces"
      yabai -m signal --add event=window_destroyed action="sketchybar --trigger windows_on_spaces"
    '';
  };
}
