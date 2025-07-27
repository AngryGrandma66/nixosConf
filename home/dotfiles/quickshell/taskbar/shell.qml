import Quickshell
import QtQuick 
Scope {

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 25
      Rectangle {
          id: left
      }
      Rectangle {
          id:center 
      }
      Rectangle {
          id:right 
      }
      ClockWidget {
        anchors.centerIn: parent

      }
    }
  }
}
