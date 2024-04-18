{ config, pkgs, ... }:

{
	imports =[
	./gnome.nix
	#./kde.nix
	];
	services.xserver.enable = true;
}
