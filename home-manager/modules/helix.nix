{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    moduleHelix.enable = lib.mkEnableOption "enables starship" // {
      default = true;
    };
  };

  config = lib.mkIf config.moduleHelix.enable {
    home.packages = with pkgs; [
      simple-completion-language-server
      nixd
    ];

    programs.helix = {
      enable = true;

      # languages = {
      #   language-server = {
      #     scls = {
      #       command = "simple-completion-language-server";

      #       config = {
      #         max_completion_items = 100;
      #         feature_words = true;
      #         feature_snippets = true;
      #         snippets_first = true;
      #         snippets_inline_by_word_trail = false;
      #         feature_unicode_input = false;
      #         feature_paths = true;
      #         featue_citations = false;
      #       };

      #       enviornment = {
      #         LOG_FILE = "/tmp/completion.log";
      #         NIX_LOG = "info,simple-completion-language-server=info";
      #       };
      #     };
      #   };

      #   language = [
      #     {
      #       name = "nix";
      #       auto-format = true;

      #       indent = { tab-width = 4; unit = "    "; };

      #       language-servers = [
      #         "scls"
      #         "nixd"
      #       ];
      #     }
      #   ];
      # };

      settings = {
        theme = "catppuccin_mocha";
        
        editor = {
          soft-wrap = {
            enable = true;
          };

          line-number = "relative";
          lsp.display-messages = true;
          color-modes = true;
          bufferline = "multiple";

          statusline = {
            mode = {
              normal = "NORMAL";
              insert = "INSERT";
              select = "SELECT";
            };

            right = [ "file-type" "position" ];
          };

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "block";
          };
        };
      };
    };

    xdg.configFile."helix/languages.toml".text = ''
      [[language]]
      auto-format = false
      language-servers = ["scls", "nixd"]
      name = "nix"
      indent = { tab-width = 2, unit = "  " }

      
      [[language]]
      auto-format = false
      language-servers = ["qmlls", "scls"]
      name = "qml"
      indent = { tab-width = 2, unit = "  " }

      [language-server.scls]
      command = "simple-completion-language-server"

      [language-server.scls.config]
      featue_citations = false
      feature_paths = true
      feature_snippets = true
      feature_unicode_input = false
      feature_words = true
      max_completion_items = 100
      snippets_first = true
      snippets_inline_by_word_trail = false

      [language-server.scls.enviornment]
      LOG_FILE = "/tmp/completion.log"
      NIX_LOG = "info,simple-completion-language-server=info"
    '';
  };
}
