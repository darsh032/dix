{ config, lib, pkgs, ... } : {
  options = {
    moduleCommandPrograms.enable = lib.mkEnableOption "enables commons" // {
      default = true; 
    };
  };

  config = lib.mkIf config.moduleCommandPrograms.enable {
    home.packages = with pkgs; [
      vesktop
      zoxide
      eza
    ];
  };
}
