{ config, username, ... }: {
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";

    moduleAsztal.enable = true;

    home.sessionVariables = {
    };

    home.sessionPath = [
        "$HOME/.local/bin"
    ];

    programs.home-manager.enable = true;
    home.stateVersion = "24.11";
}
