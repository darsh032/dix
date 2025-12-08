{ lib, config, pkgs, self, ... }: {
  options = {
    moduleHelix.enable = lib.mkEnableOption "Enables Helix" // {
      default = true;
    };
  };
  config = lib.mkIf config.moduleHelix.enable {
    home.packages = with pkgs; [
      self.packages.${pkgs.stdenv.hostPlatform.system}.hx-regular  
    ];
  };	
}
