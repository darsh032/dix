{ config, pkgs, ... }: {
  imports = [
      ./hardware-configuration.nix
    ];

  hardware.nvidia = {
  modesetting.enable = true;
  powerManagement.enable = true;
  open = false;
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.stable;
};

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
     helix
     git
  ];

nix.settings.experimental-features = [ "flakes" "nix-command" ];

  system.stateVersion = "25.05";

}
