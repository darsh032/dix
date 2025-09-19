{inputs, pkgs, config, lib, ...}:  {
  options = {
    moduleColemak.enable = lib.mkEnableOption "enables colemak" // {
      default = true;
    };
  };

  config = lib.mkIf config.moduleColemak.enable {
    services.xserver.xkb.layout = "us,us";
    services.xserver.xkb.variant = ",colemak_dh_ortho";
    services.xserver.xkb.options = "grp:alt_shift_toggle";
    console.useXkbConfig = true  ;
  };
}
