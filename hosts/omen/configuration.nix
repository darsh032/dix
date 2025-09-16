{ config, pkgs, username, ... }: {
  imports = [
      ./hardware-configuration.nix
    ];

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

  users.users.${username} = {
    isNormalUser = true;
    description = "Darsh yadav";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [
     neovim
     home-manager
     git
  ];

nix.settings.experimental-features = [ "flakes" "nix-command" ];

  system.stateVersion = "25.05";

}
