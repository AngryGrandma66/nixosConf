import Quickshell
import QtQuick 
import QtQuick.Layouts
import QtQuick.Controls
Scope {

    Variants {
        model: Quickshell.screens

        PanelWindow {
              id: topBar
            required property var modelData
            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 25

            RowLayout {
                id: barLayout
                spacing: 0
                anchors.fill: parent

                RowLayout {
                    id: leftBlocks
                    spacing: 10
                    Layout.alignment: Qt.AlignLeft
                    Layout.fillWidth: true

                    ClockWidget{}
                }

                RowLayout {
                    id:centerBlocks 
                    spacing: 10
                    Layout.alignment: Qt.AlignCenter
                    Layout.fillWidth: true
                    Workspaces{}



                }


                // Right side
                RowLayout {
                    id: rightBlocks
                    spacing: 0
                    Layout.alignment: Qt.AlignRight
                    Layout.fillWidth: true

                    ClockWidget{}
                }
            }}
        }
    }
