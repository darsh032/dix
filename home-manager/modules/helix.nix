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
      nil
    ];

    programs.helix = {
      enable = true;

      languages = {
        language-server = {
          scls = {
            "command" = "simple-completion-language-server";

            config = {
              "max_completion_items" = 100;
              "feature_words" = true;
              "feature_snippets" = true;
              "snippets_first" = true;
              "snippets_inline_by_word_trail" = false;
              "feature_unicode_input" = false;
              "feature_paths" = true;
              "featue_citations" = false;
            };

            enviornment = {
              "LOG_FILE" = "/tmp/completion.log";
              "NIX_LOG" = "info,simple-completion-language-server=info";
            };
          };
        };

        language = [
          {
            "name" = "nix";
            "auto-format" = true;
            "language-servers" = [
              "scls"
              "nil_ls"
            ];
          }
        ];
      };

      settings = {
        theme = "base16_transparent";
        
        editor = {
          line-number = "relative";
          lsp.display-messages = true;
          bufferline = "multiple";

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "block";
          };
        };
      };
    };
  };
}
