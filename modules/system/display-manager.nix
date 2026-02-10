{ config, pkgs, ... }@inputs:
{
  services.displayManager = {
    enable = true;
    ly = {
      enable = true;
      package = inputs.pkgs-unstable.ly;
      settings = {
        allow_empty_password = false;
        clear_password = true;
        hide_version_string = true;
        numlock = true;
        setup_cmd =
          let
            xsession-wrapper =
              pkgs.runCommand "xsession-wrapper-fixed"
                {
                  src = config.services.displayManager.sessionData.wrapper;
                }
                ''
                  cp --preserve=mode $src $out
                  substituteInPlace $out --replace-fail \
                    "KDE|GNOME|Pantheon|X-NIXOS-SYSTEMD-AWARE" \
                    "KDE|GNOME|Pantheon|X-NIXOS-SYSTEMD-AWARE|niri"
                '';
          in
          "${xsession-wrapper}";
      };
      x11Support = false;
    };
    generic.preStart = "";
  };
}
