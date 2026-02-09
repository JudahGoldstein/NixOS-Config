{ config, pkgs, ... }@inputs:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common.default = [ "gnome" ];
    };
  };
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
  services.displayManager.ly.enable = inputs.lib.mkForce false;
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
  };
}
