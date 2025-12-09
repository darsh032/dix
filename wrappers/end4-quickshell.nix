{ pkgs, wrappers, inputs, lib, ... }:

let
  qmlPath = lib.makeSearchPath "lib/qt-6/qml" [
    pkgs.kdePackages.qt5compat
    pkgs.kdePackages.qtpositioning
    pkgs.kdePackages.syntax-highlighting
    pkgs.kdePackages.kirigami
    pkgs.kdePackages.kirigami-addons
    pkgs.kdePackages.kirigami-gallery
  ];
in

wrappers.lib.wrapPackage {
  inherit pkgs;
  package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;

  runtimeInputs = with pkgs; [
    kdePackages.qt5compat
    kdePackages.qtpositioning
    kdePackages.syntax-highlighting
    kdePackages.kirigami
    kdePackages.kirigami-addons
    kdePackages.kirigami-gallery
  ];

  env = {
    QML2_IMPORT_PATH = "${qmlPath}";
  };

  flags = {
    "-p" = "${inputs.end4}/dots/.config/quickshell/ii";
  };
  flagSeparator = " ";
}
