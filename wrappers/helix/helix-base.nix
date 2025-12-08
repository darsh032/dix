{
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
}
