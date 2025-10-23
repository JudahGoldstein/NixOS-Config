{ config, pkgs, ... }@inputs:
{
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
  stylix.polarity = "dark";
  hm.stylix.targets = {
    firefox = {
      enable = true;
      profileNames = [ "default" ];
    };
    kitty.enable = true;
    gnome.enable = true;
    qt.enable = true;
    lazygit.enable = true;
    micro.enable = true;
    obsidian.enable = true;
    nixos-icons.enable = true;
    vesktop.enable = true;
    eog.enable = true;
    gnome-text-editor.enable = true;
    vscode.enable = true;
  };
  stylix.autoEnable = false;
}
