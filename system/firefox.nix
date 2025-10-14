{ config, pkgs, ... }@inputs:
{
  options =
    {
      firefox.enable = inputs.lib.mkOption {
        default = true;
        description = "Enable Firefox";
      };
    };

  config = inputs.lib.mkIf (config.firefox.enable == true) {
    programs.firefox = {
      enable = true;
      #profiles.default.search.default = "DuckDuckGo"; #for some reason this causes a clobbering issue...
    };
  };
}
