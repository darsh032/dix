{ config, lib, ... }: {
   options = {
     systemNetworking.enable = lib.mkEnableOption "enables networknig" // {
       default = true;
     };
   };

   config = lib.mkIf config.systemNetworking.enable {
     networking = {
       hostName = "nixos";
       networkmanager.enable = true;
     };
   };
}
