{ config, pkgs, ... }@inputs:
{
  options = {
    softColemak.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = false;
      description = "Enable soft Colemak layout for console. use for laptops with sticker keycaps.";
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
      glibcLocales
      hunspell
      hunspellDicts.en_CA-large
      texliveMedium
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
