{ config, pkgs, inputs, ... }:

let
  userName = "awesome";
in {
   users.users.awesome = {
    isNormalUser = true;
    description = "Darsh yadav";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    
    packages = with pkgs; [
      # Caelestia
      inputs.caelestia-shell.packages.${system}.default
      inputs.caelestia-cli.packages.${system}.default
      wl-clipboard
      cliphist
      libnotify

      # idk
      starship
      nerd-fonts.jetbrains-mono
      
      # Helix general LSPs
      nixd
      rust-analyzer
      simple-completion-language-server

      # Hyprland stuff
      kitty
      fuzzel
      bibata-cursors

      # daily
      firefox
    ];
  };

  programs.fish.enable = true;

  hjem = {
    extraModules = [ inputs.hjem-impure.hjemModules.default ];
    
    users.${userName} = {
      impure = {
        enable = true;
        dotsDir = "${./dots}";
        dotsDirImpure = "/home/${userName}/dix/users/dots";
        parseAttrs = [config.hjem.users.${userName}.xdg.config.files];
      };

      clobberFiles = true;
      
      xdg.config.files = let
        dots = config.hjem.users.${userName}.impure.dotsDir;
      in {
        # Helix
        ".config/helix".source = dots + ./helix;

        # Fish
        ".config/fish".source = dots + ./fish;
        ".config/starship.toml".source = dots + ./starship.toml;

        # Hyprland
        ".config/hypr/hyprland.conf".source = dots + ./hypr/hyprland.conf;

        # Kitty
        ".config/kitty/kitty.conf".source = dots + ./kitty/kitty.conf;

        # Git
        ".gitconfig".source = dots + ./dot_gitconfig;
      };
      
      files = {
        # Firefox
        ".mozilla/firefox/profiles.ini".source = ./dots/firefox/profiles.ini;
        ".mozilla/firefox/default/user.js".source = ./dots/firefox/default/user.js;
        ".mozilla/firefox/default/extensions".source = ./dots/firefox/default/extensions;
      };
    };
  };
}
