{ lib, config, ... }: {
  options = {
    moduleFish = lib.mkEnableOption "enables fish" // {
      default = true;
    };
  }; 

  config = lib.mkIf config.moduleFish.enable {
    programs.fish = {
      enable = true;
      
      shellInit = "
        set fish_greeting
      ";

      shellAliases = {
        "hr" = "home-manager switch --flake";
        "nr" = "sudo nixos-rebuild switch --flake";
      };
    };
  };
}
