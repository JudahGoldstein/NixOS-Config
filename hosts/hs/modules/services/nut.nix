{ config, pkgs, ... }@inputs:
{
  power.ups = {
    enable = true;
    mode = "standalone";
    ups."cyberpower-avr-1000" = {
      driver = "usbhid-ups";
      port = "auto";
    };
    users.nutmon = {
      passwordFile = config.sops.secrets."nutmon-password".path;
      upsmon = "primary";
    };
    upsmon = {
      user = "nutmon";
      monitor = {
        "cyberpower-avr-1000" = {
          user = config.power.ups.upsmon.user;
        };
      };
    };
  };
}
