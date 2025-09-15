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
       };
    };
}
