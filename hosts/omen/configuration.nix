{ config, pkgs, ... }: {
  imports = [
      ./hardware-configuration.nix
    ];


  moduleSpicetify.enable = true;
  moduleQt.enable = true;
    
  fonts.fontconfig.enable = true;
  programs.hyprland.enable = true;
    
  # Enable proprietary NVIDIA driver
  services.flatpak.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # Optional: enable NVIDIA persistence and settings
  hardware.nvidia.modesetting.enable = true;

  hardware.nvidia.open = true;

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
