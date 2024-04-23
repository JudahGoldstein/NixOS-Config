{config, pkgs, ...}:
{
	networking = {
		networkmanager.enable = true;
		hostName = "nixos";
	};
}
