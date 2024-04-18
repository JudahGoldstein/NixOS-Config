{ config, pkgs, ... }:
{
	nixpkgs.config.allowUnfree = true;
	
	environment.systemPackages = with pkgs; 
	[
	#downloaders
	wget
	curl
	git

	#fonts
	nerdfonts
	noto-fonts
	noto-fonts-cjk
	noto-fonts-emoji
	];

	# List services that you want to enable:
	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;
}
