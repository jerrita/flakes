{pkgs, ...}: {
  fonts.packages = with pkgs; [
    meslo-lgs-nf
    jetbrains-mono
    sketchybar-app-font
  ];
}
