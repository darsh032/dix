{ config, username, ... }: {
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";

    imports = [
	./packages.nix
    ];

    moduleAsztal.enable = true;

    home.sessionVariables = {
        EDITOR = "nvim";
    };

    home.sessionPath = [
        "$HOME/.local/bin"
    ];

    programs.home-manager.enable = true;
    home.stateVersion = "24.11";
}
