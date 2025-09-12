{ pkgs, ... }:

{
	programs.chromium = {
		enable = true;
		extensions = [
			# TotalBlock
			{ id = "gekdekpbfehejjiecgonmgmepbdnaggp"; }

			# ProtonPass
			{ id = "ghmbeldphafepmbegfdlkpapadhbakde"; }
		];
	};
}
