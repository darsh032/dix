{ pkgs, config, lib, ... }: {
    options = {
	moduleKitty.enable = lib.mkEnableOption "Enables kitty" // {
            default = true;
	};
    };

    config = lib.mkIf config.moduleKitty.enable {
    	programs.kitty = {
	    enable = true;

	    settings = {
 	        confirm_os_window_close = 0;
                shell = "fish";

                font_family = "family='JetBrainsMono Nerd Font'";
                font_size = "18";
	    };
        };

        home.packages = with pkgs; [
          nerd-fonts.jetbrains-mono
        ];

        fonts.fontconfig.enable = true;
    };
}
