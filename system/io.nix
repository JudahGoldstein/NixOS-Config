{ config, pkgs, ... }:
{
    services.printing.enable = true;
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        pulse.support32Bit = true;
    };
    services.xserver.libinput.enable = true;
}
