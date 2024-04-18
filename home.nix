{ config, pkgs, ... }:
let 
	username = "judah";
	homeDirectory = "/home/" + username;
in
{
	imports = 
	[
	./user/shell/sh.nix
	./user/browser/firefox.nix
	./user/packages.nix
	./user/git.nix
	./user/shell/terminal/terminal.nix
	];
	# Home Manager needs a bit of information about you and the paths it should
	# manage.
	home.username = username;
	home.homeDirectory = homeDirectory;

	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {};

	home.sessionVariables = {
		EDITOR = "micro"; #nixvim coming soon I promise
		BROWSER = "firefox";
		TERMINAL = "kitty";
		TERM = "kitty";
	};

	# You should not change this value, even if you update Home Manager. If you do
	# want to update the value, then make sure to first check the Home Manager
	# release notes.
	home.stateVersion = "23.11"; # Please read the comment before changing.

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
