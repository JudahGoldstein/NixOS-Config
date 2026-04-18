{
  config,
  lib,
  pkgs,
  ...
}:
{
  specialisation.desktopMode.configuration = {
    services.udev.extraRules = ''
      KERNEL=="event*", SUBSYSTEM=="input", ATTRS{name}=="AT Translated Set 2 keyboard", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      KERNEL=="event*", SUBSYSTEM=="input", ATTRS{name}=="ThinkPad Extra Buttons", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      KERNEL=="event*", SUBSYSTEM=="input", ATTRS{name}=="TPPS/2 Elan TrackPoint", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      KERNEL=="event*", SUBSYSTEM=="input", ATTRS{name}=="SynPS/2 Synaptics TouchPad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      KERNEL=="event*", SUBSYSTEM=="input", ATTRS{name}=="Power Button", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    '';
  };
}
