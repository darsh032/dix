{ ... }: {
    imports = [
      ./core/boot.nix
      ./core/networking.nix
      ./core/timezone.nix
      ./core/locale.nix
    ];
}
