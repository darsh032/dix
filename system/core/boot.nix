{ config, lib, ... }: {
  options = {
    systemBoot.enable = lib.mkEnableOption "enables systemdBoot" // {
      default = true;
    };
  };

  config = lib.mkIf systemBoot.enable {
     boot = {
       loader = {
         systemd-boot.enable = true;
         efi.canTouchEfiVariables = true;
       };

       plymouth.enable = true;
     };
  };
}
