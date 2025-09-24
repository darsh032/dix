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
      simple-simple-completion-language-server
    ];
  };

  hjem.users.awesome = {
    files = {
      ".mozilla/firefox/profiles.ini".source = ./dots/firefox/profiles.ini;
      ".mozilla/firefox/default/user.js".source = ./dots/firefox/default/user.js;
      ".mozilla/firefox/default/extensions".source = ./dots/firefox/default/extensions;
    };
  };
}
