{ pkgs, lib, config, ... }: {
	options = {
	moduleBrowser.enable = lib.mkEnableOption "enables chromium with my favorite extensions" // {
      	    default = true;
        };

	};

	config = lib.mkIf config.browser.enable {
		programs.chromium = {
			enable = true;
			extensions = [
# TotalBlock
			{ id = "gekdekpbfehejjiecgonmgmepbdnaggp"; }

# ProtonPass
			{ id = "ghmbeldphafepmbegfdlkpapadhbakde"; }

			# ProtonVpn
			{ id = "jplgfhpmjnbigmhklmmbgecoobifkmpa"; }
			];
		};
	};	
}
