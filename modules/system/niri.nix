{ config, pkgs, ... }@inputs:
{
  programs.niri = {
    enable = true;
    package = pkgs.niri-stable;
  };
  hm.programs.niri = {
    settings = {
      input.keyboard = {
        numlock = true;
        xkb = {
          layout = "us, us(colemak)";
          options = "grp:win_space_toggle";
        };
      };
    };
  };
  programs.dms-shell = {
    enable = true;
    enableClipboardPaste = true;
    enableSystemMonitoring = true;
  };
}
