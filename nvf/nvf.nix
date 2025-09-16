{ pkgs, lib, ... }: {
  vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    lsp.enable = true;

    languages = {
      enableTreesitter = true;
      nix.enable = true;
      rust.enable = true;
    };

    additionalRuntimePaths = [
      ./nvim
    ];

    luaConfigRC.myconfig = /* lua */ ''
      require("myconfig")
      '';

    lazy.plugins = {
      "nvim-autopairs" = {
        package = pkgs.vimPlugins.nvim-autopairs;
        setupModule = "nvim-autopairs";
        setupOpts = {
          check_ts = true;
          fast_wrap = {};
        };
      };

      "nvim-treesitter-context" = {
        package = pkgs.vimPlugins.nvim-treesitter-context;
        setupModule = "treesitter-context";
        setupOpts = {
          enable = true;
          max_lines = 3;
        };
      };
    };
  };
}
