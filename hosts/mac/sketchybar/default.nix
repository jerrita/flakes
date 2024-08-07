{pkgs, ...}: {
  homebrew.casks = ["sf-symbols"];
  homebrew.brews = ["switchaudio-osx"];

  system.defaults.NSGlobalDomain._HIHideMenuBar = true;

  services.sketchybar = {
    enable = true;
    extraPackages = with pkgs; [jq ifstat-legacy jetbrains-mono skhd];
    config = ''
      #!/bin/bash
      export CONFIG_DIR=${./config}
      source "$CONFIG_DIR/colors.sh" # Loads all defined colors
      source "$CONFIG_DIR/icons.sh"  # Loads all defined icons

      ITEM_DIR="$CONFIG_DIR/items"     # Directory where the items are configured
      PLUGIN_DIR="$CONFIG_DIR/plugins" # Directory where all the plugin scripts are stored

      FONT="SF Pro" # Needs to have Regular, Bold, Semibold, Heavy and Black variants
      PADDINGS=2    # All paddings use this value (icon, label, background)

      # Setting up and starting the helper process
      HELPER=git.felix.helper
      killall helper
      # (cd $CONFIG_DIR/helper && make)
      $CONFIG_DIR/helper/helper $HELPER >/dev/null 2>&1 &

      # Unload the macOS on screen indicator overlay for volume change
      # launchctl unload -F /System/Library/LaunchAgents/com.apple.OSDUIHelper.plist >/dev/null 2>&1 &

      # Setting up the general bar appearance of the bar
      bar=(
      	height=34
      	color=$BAR_COLOR
      	border_width=2
      	border_color=$BAR_BORDER_COLOR
      	shadow=off
      	position=top
      	sticky=on
      	padding_right=10
      	padding_left=10
      	y_offset=3
      	margin=8
      	corner_radius=10
      	blur_radius=20
      	shadow=on
      )

      sketchybar --bar "''${bar[@]}"

      # Setting up default values
      defaults=(
      	updates=when_shown
      	icon.font="$FONT:Bold:14.0"
      	icon.color=$ICON_COLOR
      	icon.padding_left=$PADDINGS
      	icon.padding_right=$PADDINGS
      	label.font="$FONT:Semibold:13.0"
      	label.color=$LABEL_COLOR
      	label.padding_left=$PADDINGS
      	label.padding_right=$PADDINGS
      	padding_right=$PADDINGS
      	padding_left=$PADDINGS
      	background.padding_right=$PADDINGS
      	background.padding_left=$PADDINGS
      	background.height=26
      	background.corner_radius=9
      	background.border_width=2
      	popup.background.border_width=2
      	popup.background.corner_radius=9
      	popup.background.border_color=$POPUP_BORDER_COLOR
      	popup.background.color=$POPUP_BACKGROUND_COLOR
      	popup.blur_radius=20
      	popup.background.shadow.drawing=on
      )

      sketchybar --default "''${defaults[@]}"

      # Left
      source "$ITEM_DIR/apple.sh"
      source "$ITEM_DIR/spaces.sh"
      source "$ITEM_DIR/yabai.sh"
      source "$ITEM_DIR/front_app.sh"

      # Center
      # source "$ITEM_DIR/spotify.sh"

      # Right
      source "$ITEM_DIR/calendar.sh"
      # source "$ITEM_DIR/brew.sh"
      # source "$ITEM_DIR/github.sh"
      # source "$ITEM_DIR/volume.sh"
      source "$ITEM_DIR/battery.sh"
      source "$ITEM_DIR/wechat.sh"
      source "$ITEM_DIR/qq.sh"
      source "$ITEM_DIR/network.sh"
      source "$ITEM_DIR/cpu.sh"
      # source "$ITEM_DIR/cava.sh"
      # source "$ITEM_DIR/music.sh"

      # Forcing all item scripts to run (never do this outside of sketchybarrc)
      sketchybar --update

      echo "sketchybar configuation loaded.."
    '';
  };
}
