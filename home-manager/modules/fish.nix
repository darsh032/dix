{ lib, config, ... }: {
  options = {
    moduleFish.enable = lib.mkEnableOption "enables fish" // {
      default = true;
    };
  }; 

  config = lib.mkIf config.moduleFish.enable {
    home.sessionVariables = {
      SHELL = "fish";
    };
    
    programs.fish = {
      enable = true;
      
      shellInit = "
        set fish_greeting
      ";

      shellAliases = {
        "hr" = "home-manager switch --flake";
        "nr" = "sudo nixos-rebuild switch --flake";
        "nd rustlings" = "nix develop ~/dix#rustlings";
        "nd qs" = "nix develop ~/dix#quickshell";
      };
    };
  };
}
