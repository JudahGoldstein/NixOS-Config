{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    kitty.enable = mkOption {
      type = lib.types.bool;
      default = true;
    };
    terminal-recording.enable = mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
  config = {
    environment.systemPackages = with pkgs; lib.filter (pkg: pkg != null)
      [
        (if config.kitty.enable then kitty else null)
        (if config.terminal-recording.enable then asciinema else null)
        (if config.terminal-recording.enable then asciinema-agg else null)
        (if config.terminal-recording.enable then termshot else null)
      ];
    programs.starship = {
      enable = true;
      presets = [ "gruvbox-rainbow" ];
    };
  };
}
