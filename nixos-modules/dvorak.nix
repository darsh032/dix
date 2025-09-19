{inputs, pkgs, config, lib, ...}:  {
  options = {
    moduleDvorak.enable = lib.mkEnableOption "enables hyprland" // {
      default = true;
    };
  };

  config = lib.mkIf config.moduleHyprland.enable {
    services.xserver.xkb.layout = "us,us";
    services.xserver.xkb.variant = "dvorak,";
    services.xserver.xkb.options = "grp:alt_shift_toggle";
    console.useXkbConfig = true  ;
  };
}
