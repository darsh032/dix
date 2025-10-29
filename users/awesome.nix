{ dirName, config, pkgs, inputs, ... }:

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
      eza
      zoxide
      bat
      glow
      starship
      nerd-fonts.jetbrains-mono
      
      # Helix general LSPs
      nixd
      rust-analyzer
      marksman
      simple-completion-language-server

      # Hyprland stuff
      kitty
      fuzzel
      bibata-cursors

      # daily
      firefox

      # Youtube.
      davinci-resolve
      audacity
    ];
  };

  programs.fish.enable = true;

  hjem = {
    extraModules = [ inputs.hjem-impure.hjemModules.default ];
    
    users.${userName} = {
      impure = {
        enable = true;
        dotsDir = "${./dots}";
        dotsDirImpure = "/home/${userName}/${dirName}/users/dots";
        parseAttrs = [config.hjem.users.${userName}.xdg.config.files];
      };

      clobberFiles = true;
      
      xdg.config.files = let
        dots = config.hjem.users.${userName}.impure.dotsDir;
      in {
        # Helix
        "helix".source = dots + "/helix";

        # Fish
        "fish".source = dots + "/fish";
        "starship.toml".source = dots + "/starship.toml";

        # Hyprland
        "hypr/hyprland.conf".source = dots + "/hypr/hyprland.conf";

        # Kitty
        "kitty/kitty.conf".source = dots + "/kitty/kitty.conf";

        # Quickshell
        "quickshell/mane".source = dots + "/quickshell";
      };
      
      files = let
        dots = config.hjem.users.${userName}.impure.dotsDir;
      in {
        # Firefox
        ".mozilla/firefox/profiles.ini".source = dots + "/firefox/profiles.ini";
        ".mozilla/firefox/default/user.js".source = dots + "/firefox/default/user.js";
        ".mozilla/firefox/default/extensions".source = dots + "/firefox/default/extensions";

        # Git
        ".gitconfig".source = ./dots/dot_gitconfig;
      };
    };
  };

    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "awesome";

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
