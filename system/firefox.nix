{ config, pkgs, lib, ... }:
{
  options =
    {
      firefox.enable = lib.mkOption {
        default = true;
        description = "Enable Firefox";
      };
    };

  config = lib.mkIf (config.firefox.enable == true) {
    programs.firefox = {
      enable = true;
      #profiles.default.search.default = "DuckDuckGo"; #for some reason this causes a clobbering issue...
    };
  };
}
