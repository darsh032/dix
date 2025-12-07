{ lib, config, pkgs, ... }: {
  options = {
    moduleBrave.enable = lib.mkEnableOption "Enables brave" // {
      default = true;
    };

  };
  config = lib.mkIf config.moduleBrave.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;

      extensions = [
        { id = "mmioliijnhnoblpgimnlajmefafdfilb"; }
        { id = "ghmbeldphafepmbegfdlkpapadhbakde"; }
      ];
    };
  };	
}
