import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

PanelWindow {
  anchors {
    top: true
    right: true
    left: true
  }

  implicitHeight: 30

  Row {
    anchors {
      verticalCenter: parent.verticalCenter
      left: parent.left
      leftMargin: 4
    }
    spacing: 4

    Repeater {
      model: 5

      Button {
        required property int index
        text: index + 1

        onClicked: Hyprland.dispatch("workspace " + (index + 1))
      }
    }
  }
}
