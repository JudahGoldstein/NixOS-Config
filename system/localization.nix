{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    softColemak.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable soft Colemak layout for console. use for laptops with sticker keycaps.";
    };
  };

  config = {
    environment.systemPackages = [ pkgs.glibcLocales ];
    time.timeZone = "America/Toronto";
    i18n.defaultLocale = "en_CA.UTF-8";
    services.xserver.xkb = {
      layout = "us";
      variant = "colemak";
    };
    console.useXkbConfig = config.softColemak.enable;
    fonts.enableDefaultPackages = true;
  };
}
