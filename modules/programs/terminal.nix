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
  hm.programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
    };
  };
}
