{ pkgs, lib, config, ... }:

{
	options = {
		browser.enable = lib.mkEnableOption "installs chromium with my favorite extensions";
	};

	config = lib.mkIf config.browser.enable {
		programs.chromium = {
			enable = true;
			extensions = [
# TotalBlock
			{ id = "gekdekpbfehejjiecgonmgmepbdnaggp"; }

# ProtonPass
			{ id = "ghmbeldphafepmbegfdlkpapadhbakde"; }
			];
		};
	};	
}
