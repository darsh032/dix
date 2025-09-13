{ config, username, ... }: {
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";

    imports = [
	../modules/default.nix
	./packages.nix
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
    };

    home.sessionPath = [
        "$HOME/.local/bin"
    ];

    programs.home-manager.enable = true;
    home.stateVersion = "24.11";
}
