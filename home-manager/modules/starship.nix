{ config, lib, ... } : {
  options = {
    moduleStarship.enable = lib.mkEnableOption "enables starship" // {
      default = true; 
    };
  };

  config = lib.mkIf config.moduleStarship.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      
      settings = {
        add_newline = true;
        
        format = lib.concatStrings [
          "[](bold blue)"
        ];

        right_format = lib.concatStrings [
          "$all"
        ];
      };
    };
  };
}
