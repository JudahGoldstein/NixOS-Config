{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    cyber.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable cyberseculity/ctf tools configuration";
    };
  };
  config = mkIf config.cyber.enable {
    home.packages = with pkgs;
      [
        metasploit
        msfpc
        nmap
        sqlmap
        john
        thc-hydra
        hashcat
        hashcat-utils
        enum4linux
        enum4linux-ng
        wireshark
        bettercap
        burpsuite
        ettercap
        aircrack-ng
        airgeddon
        reaverwps-t6x
        dirbuster
        stegseek
        stegsolve
        steghide
        exploitdb
      ];
  };
}
