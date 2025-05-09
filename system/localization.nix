{ config, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.glibcLocales ];
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak";
  };
  console.useXkbConfig = true;
  fonts.enableDefaultPackages = true;
}
