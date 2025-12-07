{ lib, config, pkgs, ... }: {
  options = {
    moduleChromium.enable = lib.mkEnableOption "Enables Chromium" // {
      default = true;
    };

  };
  config = lib.mkIf config.moduleChromium.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.chromium;

      extensions = [
        { id = "mmioliijnhnoblpgimnlajmefafdfilb"; }
        { id = "ghmbeldphafepmbegfdlkpapadhbakde"; }
        { id = "jpkfgepcmmchgfbjblnodjhldacghenp"; }
      ];
    };
  };	
}
