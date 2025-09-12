{ config, ... }:

{
    home.username = "awesome";
    home.homeDirectory = "/home/awesome";

    # Import your modules
    imports = [
    	../modules/chromium.nix
	../modules/git.nix
	./packages.nix
    ];


    # Session Variables
    home.sessionVariables = {
        EDITOR = "nvim";
    };

    # Extend PATH cleanly
    home.sessionPath = [
        "$HOME/.local/bin"
    ];

    # Enable Home Manager
    programs.home-manager.enable = true;

    # Required for backwards compatibility
    home.stateVersion = "24.11";
}
