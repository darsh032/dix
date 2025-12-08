{ pkgs, wrappers }:

(wrappers.wrapperModules.helix.apply {
  inherit pkgs;

  settings = {
    theme = "catppuccin_mocha";

    editor = {
      soft-wrap.enable = true;
      line-number = "relative";
      color-modes = true;
      bufferline = "multiple";

      lsp.display-messages = true;

      statusline = {
        mode.normal = "NORMAL";
        mode.insert = "INSERT";
        mode.select = "SELECT";
        right = [ "file-type" "position" ];
      };

      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "block";
      };
    };
  };

  languages = {
    language = [
      {
        name = "nix";
        auto-format = false;
        indent = { tab-width = 2; unit = "  "; };
        language-servers = [ "scls" "nixd" ];
      }

      {
        name = "qml";
        auto-format = false;
        indent = { tab-width = 2; unit = "  "; };
        language-servers = [ "qmlls" "scls" ];
      }
    ];

    language-server = {
      scls = {
        command = "simple-completion-language-server";

        config = {
          max_completion_items = 100;
          feature_words = true;
          feature_snippets = true;
          snippets_first = true;
          snippets_inline_by_word_trail = false;
          feature_unicode_input = false;
          feature_paths = true;
          featue_citations = false;
        };

        enviornment = {
          LOG_FILE = "/tmp/completion.log";
          NIX_LOG = "info,simple-completion-language-server=info";
        };
      };
    };
  };

  themes = { };
  ignores = [ ];
}).wrapper
