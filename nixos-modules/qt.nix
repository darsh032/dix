{ config, lib, pkgs, ...}:  {
  options = {
    moduleQt.enable = lib.mkEnableOption "enables Qt";
  };

  config = lib.mkIf config.moduleQt.enable {
    environment.systemPackages = with pkgs; [
      kdePackages.qt5compat
    ];

    qt.enable = true;
  };
}
