{ pkgs, lib, config, inputs, system, ... }: {
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
          "startup.homepage_welcome_url" = "about:blank";
          "browser.startup.homepage" = "about:blank";
        };

        extensions = {
          packages = with inputs.firefox-addons.packages.${system}; [
            ublock-origin-upstream
            proton-pass
            proton-vpn
            simple-dark-vlasak
          ];
        };
        
        search = {
          default = "ddg";
          privateDefault = "ddg";
          force = true;
        };
      };
    };
  };	
}
