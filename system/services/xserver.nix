{ config, lib, ... }: {
  options = {
    systemXserver.enable = lib.mkEnableOption "enables xservera" // {
      default = true;
    };
  };

  config = lib.mkIf config.systemXserver.enable {
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
  };
}
