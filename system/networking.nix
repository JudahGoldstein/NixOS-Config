{config, pkgs, ...}:
{
	networking = {
		networkmanager.enable = true;
		hostName = "nixos";
		networking.wireless.enable = true;
	};
}
