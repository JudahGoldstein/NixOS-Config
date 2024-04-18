{config, pkgs, ...}:
{
	programs.firefox = {
		enable = true;
	#	profiles.default.search.default = "DuckDuckGo"; #for some reason this causes a clobbering issue...
	};	
}
