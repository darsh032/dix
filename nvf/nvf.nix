{ ... }: {
  vim = { theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
    };

    statusline.lualine.enable = true;
    autopairs.nvim-autopairs.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    lsp.enable = true;

    languages = {
      enableTreesitter = true;
      nix.enable = true;
      rust.enable = true;
    };

    dashboard = {
      dashboard-nvim.enable = true;
    };

    visuals = {
      fidget-nvim.enable = true;
      indent-blankline.enable = true;
      rainbow-delimiters.enable = true;
    };

    binds = {
      whichKey.enable = true;
    };      

    treesitter.context = {
      enable = true;
    };

    additionalRuntimePaths = [
      ./nvim
    ];

    luaConfigRC.myconfig = /* lua */ ''
      require("myconfig")
      '';
  };
}
