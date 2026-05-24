{ config, pkgs, ... }@inputs:
{
  longName = "Judah (v14)";
  sops.age = {
    keyFile = inputs.lib.mkForce "/persist/root/.config/sops/age/keys.txt";
    sshKeyPaths = inputs.lib.mkForce [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
  };
  programs.captive-browser = {
    enable = true;
    interface = "wlp2s0";
  };
  hm.programs.niri.settings.outputs = {
    "eDP-1" = {
      position.x = 0;
      position.y = 0;
      scale = 1.0;
    };
  };
  softColemak.enable = true;
}
