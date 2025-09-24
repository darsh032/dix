{ pkgs, inputs, ... }: {
   users.users.awesome = {
    isNormalUser = true;
    description = "Darsh yadav";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    
    packages = with pkgs; [
      # Caelestia
      input.caelestia-shell.packages.${system}.default
      input.caelestia-cli.packages.${system}.default
      wl-clipboard
      cliphist
      libnotify

      # idk
      starship
      
      # Helix general LSPs
      nixd
      rust-analyzer
      simple-completion-language-server

      # Hyprland stuff
      kitty

      # daily
      firefox
    ];
  };

  programs.fish.enable = true;

  hjem.users.awesome = {
    files = {
      # Firefox
      ".mozilla/firefox/profiles.ini".source = ./dots/firefox/profiles.ini;
      ".mozilla/firefox/default/user.js".source = ./dots/firefox/default/user.js;
      ".mozilla/firefox/default/extensions".source = ./dots/firefox/default/extensions;

      # Helix
      ".config/helix".source = ./dots/helix;

      # Fish
      ".config/fish".source = ./dots/fish;
      ".config/starship.toml".source = ./dots/starship.toml;

      # Hyprland
      ".config/hypr/hyprland.conf".source = ./dots/hypr/hyprland.conf
    };
  };
}
