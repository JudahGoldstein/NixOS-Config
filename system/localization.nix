{ config, pkgs, ... }:
{
	# Set your time zone.
	time.timeZone = "America/Toronto";
	
	# Select internationalisation properties.
	i18n.defaultLocale = "en_CA.UTF-8";

		# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "colemak";
	};
}
