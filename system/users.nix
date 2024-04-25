{ config, pkgs, ... }:
{
    users.users.judah = {
        isNormalUser = true;
        description = "judah";
        extraGroups = [ "networkmanager" "wheel" "dialout"];
        packages = with pkgs; [];
    };
}
