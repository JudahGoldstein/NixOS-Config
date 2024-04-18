{ config, pkgs, ... }:
{
	programs.git = {
		enable = true;
		userName  = "Judah";
		userEmail = "yehudah.lev+github@gmail.com";
		extraConfig.init.defaultBranch = "main";
	};
	
	programs.gh = {
		enable = true;
		gitCredentialHelper ={
		 enable = true;
		 hosts = ["https://github.com"];
		};	
	};
}
