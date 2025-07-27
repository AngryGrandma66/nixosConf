import Quickshell
import QtQuick 
import QtQuick.Layouts
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
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true
        anchors.centerIn: parent
                    ClockWidget{}
                }

                // Without this filler item, the active window block will be centered
                // despite setting left alignment
                Item {
                    Layout.fillWidth: true
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
