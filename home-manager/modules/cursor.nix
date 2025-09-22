{ pkgs, config, lib, ... }: {
   options = {
     moduleCursor.enable = lib.mkEnableOption "enables cursor" // {
       default = true;
     };
   };

   config = lib.mkIf config.moduleCursor.enable {
      home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 19;
      };
   };
}
