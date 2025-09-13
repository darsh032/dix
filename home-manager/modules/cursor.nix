{ pkgs, config, lib ... }: {
   options = {
     moduleCursor = lib.mkEnableOption "enables cursor" // {
       default = true;
     };
   };

   config = {
      home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 19;
      };
   };
}
