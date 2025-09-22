{ config, username, lib, ... }: {
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";

    moduleKitty.enable = false;
    moduleStarship.enable = false;
    moduleFish.enable = false;
    moduleHyprland.enable = false;
    moduleCursor.enable = false;
    
    linkfrg-dotfiles = {
        hyprland.enable = true;
        hyprlock.enable = true;
        ignis.enable = true;
        kitty.enable = true;

        cursorTheme.enable = true;
        fonts.enable = true;
        iconTheme.enable = true;
    };

    home.sessionVariables = {
    };

    home.sessionPath = [
        "$HOME/.local/bin"
    ];

    programs.home-manager.enable = true;
    home.stateVersion = "24.11";
}
