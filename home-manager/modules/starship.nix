{ config, lib, ... } : {
  options = {
    moduleStarship.enable = lib.mkEnableOption "enables starship" // {
      default = true; 
    };
  };

  config = lib.mkIf config.moduleStarship.enable {
    programs.starship = {
      enable = true;
    };
  };
}
