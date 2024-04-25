{ config, pkgs, ... }:
{
	programs.git = {
		enable = true;
		userName  = "Judah";
		userEmail = "yehudah.lev+github@gmail.com";
		extraConfig = {
			init.defaultBranch = "main";
			push.autoSetupRemote = true;
			safe.directory = "*";
		};
	};

	programs.lazygit = {
		enable = true;
	};
}
