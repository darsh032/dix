{ config, username, ... }:

{
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";

    # Import your modules
    imports = [
	../modules/default.nix
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
