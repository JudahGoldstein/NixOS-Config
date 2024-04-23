{config, pkgs, ...}:
let 
    device = "/dev/sda";
    timeout = 3;
    configurationLimit = 5;
in
{
    boot.loader = {
        inherit timeout;
        grub = {
            enable = true;
            inherit device;
            useOSProber = false;
            inherit configurationLimit;
        };
    };
}
