{ pkgs, wrappers }:

let
  helix-base = import ./helix-base.nix;
in

(wrappers.wrapperModules.helix.apply {
  inherit pkgs;

  settings = helix-base;

  languages = {
    language = [
      {
        name = "python";
        auto-format = true;
        indent = { tab-width = 4; unit = "    "; };
        language-servers = [ "scls" "ruff" ];
        formatter = { command = "black -c"; };
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

  extraPackages = with pkgs; [
    simple-completion-language-server
    ruff
    black
  ];

  themes = { };
  ignores = [ ];
}).wrapper
