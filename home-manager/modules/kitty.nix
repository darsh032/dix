{ config, lib, ... }:

{
    options = {
	moduleKitty.enable = lib.mkEnableOption "Enables kitty" // {
            default = true;
	};
    };

    config = lib.mkIf moduleKitty.enable {
    	programs.kitty = {
	    enable = true;

	    settings = {
 	        confirm_os_window_close = 0;
	    };
        };
    };
}
