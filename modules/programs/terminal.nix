{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with pkgs; [
    fastfetch
    asciinema
    asciinema-agg
    termshot
  ];
  programs.starship = {
    enable = true;
    presets = [ "no-runtime-versions" ];
  };
  programs.nautilus-open-any-terminal = inputs.lib.mkIf config.services.desktopManager.gnome.enable {
    enable = true;
    terminal = "kitty";
  };
  hm.programs.kitty = {
    enable = true;
  };
}
