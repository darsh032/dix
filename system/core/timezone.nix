{ config, lib, ... }: {
    options = {
        systemTimezone.enable = lib.mkEnableOption "Enables timezone" // {
            default = true;
        };
    };

    config = lib.mkIf config.systemTimezone.enable {
      time.timeZone = "Asia/Kolkata";
    };
}
