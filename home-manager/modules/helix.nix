{ config, lib, ... } : {
  options = {
    moduleHelix.enable = lib.mkEnableOption "enables starship" // {
      default = true; 
    };
  };

  config = lib.mkIf config.moduleHelix.enable {
    programs.helix = {
      enable = true;
    };
  };
}
