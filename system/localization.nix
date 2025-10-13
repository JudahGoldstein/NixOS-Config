{ config, pkgs, lib, ... }:
{
  options = {
    softColemak.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable soft Colemak layout for console. use for laptops with sticker keycaps.";
    };
  };

  config = {
    environment.systemPackages = with pkgs;
      [
        glibcLocales
        hunspell
        hunspellDicts.en_CA-large
      ];
    time.timeZone = "America/Toronto";
    i18n.defaultLocale = "en_CA.UTF-8";
    services.xserver.xkb = {
      layout = "us";
      variant = "colemak";
    };
    console.useXkbConfig = config.softColemak.enable;
    fonts.enableDefaultPackages = true;
    fonts.packages = [ pkgs.nerd-fonts.fira-code ];
  };
}
