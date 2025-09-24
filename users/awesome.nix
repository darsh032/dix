{ pkgs, ... }: {
   users.users.awesome = {
    isNormalUser = true;
    description = "Darsh yadav";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    
    packages = with pkgs; [
      # Helix general LSPs
      nixd
      rust-analyzer
      simple-completion-language-server
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
    };
  };
}
