{ lib, config, ... }: {
  options = {
    moduleZellij.enable = lib.mkEnableOption "enables zellij"// {
      default = true;
    };
  };

  config = lib.mkIf config.moduleZellij.enable {
    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
