{ config, pkgs, ... }:
{
    users.users.judah = {
        isNormalUser = true;
        description = "judah";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
    };
}
