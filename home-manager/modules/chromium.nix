{ pkgs, lib, config, ... }: {
  options = {
    moduleBrowser.enable = lib.mkEnableOption "enables chromium with my favorite extensions" // {
      default = true;
    };

  };

  config = lib.mkIf config.moduleBrowser.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        # AdSkipper
        { id = "dinhbmppbaekibhlomcimjbhdhacoael"; }

        # ProtonPass
        { id = "ghmbeldphafepmbegfdlkpapadhbakde"; }

        # ProtonVpn
        { id = "jplgfhpmjnbigmhklmmbgecoobifkmpa"; }

        # Dark mode
        { id = "dmghijelimhndkbmpgbldicpogfkceaj"; }
      ];
    };
  };	
}
