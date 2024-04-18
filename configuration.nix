{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		./system/bootloader.nix
		./system/networking.nix
		./system/localization.nix
		./system/io.nix
		./system/sh.nix
		./system/packages.nix
		./system/users.nix
		./system/desktop/desktop.nix
		];

	# Enable automatic login for the user.
	services.displayManager.autoLogin.enable = true;
	services.displayManager.autoLogin.user = "judah";
	
	nix.settings.experimental-features = ["nix-command" "flakes"];

	system.stateVersion = "23.11";
}
