{ pkgs, lib, config, inputs, ... }: {
  options = {
    moduleFirefox.enable = lib.mkEnableOption "Enables firefox" // {
      default = true;
    };

  };

  config = lib.mkIf config.moduleFirefox.enable {
    programs.firefox = {
      enable = true;

      profiles.default = {
        settings = {
          "dom.security.https_only_mode" = true;
        };

        extensions = with inputs.firefox-addons.packages.${system}; [
          ublock-origin-upstream
          proton-pass
          proton-vpn
        ];
        
        search.default = "https://duckduckgo.com/?q=%s";
      };
    };
  };	
}
