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
        add_newline = false;

        format = lib.concatStrings [
          # "[](bg:#transparent fg:#262626)"
          "[  ](bg:transparent fg:blue)" 
          "$directory"
          # "[ ](fg:#262626 bg:#transparent)"
          "[ ](fg:transparent bg:transparent)"
          "[👉️](fg:transparent bg=transparent)"
        ];

        right_format = lib.concatStrings [
          "$git_status"
        ];

        directory = {
          format = "[$path]($style)";
          truncation_length = 2;
          style = "bg:transparent fg:blue";
          home_symbol = " ";
        };
      };
    };
  };
}
