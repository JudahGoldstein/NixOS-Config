{ config, pkgs, ... }:
{
    users.users.v14 = {
        isNormalUser = true;
        description = "Judah (V14)";
        extraGroups = [ "networkmanager" "wheel" "dialout" "uucp"];
        packages = with pkgs; [];
    };
}
