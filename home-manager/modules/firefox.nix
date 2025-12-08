{ lib, config, inputs, pkgs, ... }: {
  options = {
    moduleFirefox.enable = lib.mkEnableOption "Enables firefox" // {
      default = false;
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
          "browser.newtab.url" = "about:blank";
          "ui.systemUsesDarkTheme" = 2;
        };

        extensions = {
          packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            ublock-origin-upstream
            proton-pass
            proton-vpn
            new-tab-override
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
