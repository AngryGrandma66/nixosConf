import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import QtQuick.Controls

Row {
    id: mprisRow
    spacing: 6
    padding: 0

    property var topPlayer: null

    Connections {
        target: Mpris.players
        function onValuesChanged() {
            setupConnections()
        }
    }

    function setupConnections() {
        for (const player of Mpris.players.values) {
            player.trackChanged.connect(() => { topPlayer = player })
            player.postTrackChanged.connect(() => { topPlayer = player })
            player.playbackStateChanged.connect(() => { topPlayer = player })
        }
    }

    function truncate(text, maxLength) {
        if (typeof text !== "string") return ""
        if (text.length > maxLength) {
            return text.substring(0, maxLength) + "..."
        }
        return text
    }

    Component.onCompleted: setupConnections()

    Loader {
        active: topPlayer
        sourceComponent: playerComponent
    }
    Component {
        id: playerComponent

        Row {
            id: container
            spacing: 4

            property int maxTitleLength: 20
            property int maxArtistLength: 15

            Text {
                id: contentText
                text: {
                    if (!topPlayer) return ""
                    let truncatedTitle = truncate(topPlayer.trackTitle, container.maxTitleLength)
                    let truncatedArtist = truncate(topPlayer.trackArtist, container.maxArtistLength)
                    return `${truncatedTitle} - ${truncatedArtist}`
                }
                font.pixelSize: 12
                color: "black"

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: playerPopup.visible = !playerPopup.visible
                }
            }
            Repeater {
                model: [
                    { icon: "⏮", enabled: topPlayer && topPlayer.canGoPrevious, action: () => topPlayer.previous() },
                    { icon: topPlayer && topPlayer.playbackState === 2 ? "⏸" : "▶", enabled: topPlayer && topPlayer.canTogglePlaying, action: () => topPlayer.togglePlaying() },
                    { icon: "⏭", enabled: topPlayer && topPlayer.canGoNext, action: () => topPlayer.next() }
                ]
                delegate: Rectangle {
                    width: 18
                    height: 18
                    radius: 3
                    color: modelData.enabled ? "#ddd" : "#aaa"
                    opacity: modelData.enabled ? 1.0 : 0.4

                    Text {
                        anchors.centerIn: parent
                        text: modelData.icon
                        font.pixelSize: 10
                        color: "black"
                    }

                    MouseArea {
                        anchors.fill: parent
                        enabled: modelData.enabled
                        onClicked: modelData.action()
                        hoverEnabled: true
                        onEntered: parent.color = "#bbb"
                        onExited: parent.color = modelData.enabled ? "#ddd" : "#aaa"
                    }
                }
            }

            PopupWindow {
                id: playerPopup
                anchor.item: container
                implicitWidth: 320
                implicitHeight: playersRepeater.count * 300 + 20 // +20 for spacing/margins
                visible: false
                anchor.rect.y: 25


                ColumnLayout {
                    anchors.fill: parent
                    spacing: 10

                    Repeater {
                        id: playersRepeater
                        model: {
                            let arr = Array.from(Mpris.players.values)
                            if (topPlayer) {
                                arr = arr.filter(p => p.identity !== topPlayer.identity)
                                arr.unshift(topPlayer)
                            }
                            return arr
                        }

                        delegate: Rectangle {
                            width: parent.width
                            height: 300
                            radius: 10
                            color: "#3a3a3a"
                            border.color: "#555"
                            border.width: 1

                            property var player: modelData

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: 10
                                spacing: 8

                                // Cover art
                                Rectangle {
                                    Layout.alignment: Qt.AlignCenter
                                    width: 160; height: 160
                                    radius: 8
                                    color: "#222"

                                    Image {
                                        anchors.fill: parent
                                        source: player.trackArtUrl
                                        fillMode: Image.PreserveAspectCrop
                                        smooth: true
                                    }
                                }

                                // Track info
                                ColumnLayout {
                                    Layout.alignment: Qt.AlignCenter
                                    spacing: 2

                                    // Track title
                                    Text {
                                        Layout.alignment: Qt.AlignCenter
                                        text: player.trackTitle || "Unknown Title"
                                        font.pixelSize: 14
                                        font.bold: true
                                        color: "white"
                                        wrapMode: Text.Wrap   // wrap at word boundaries
                                        horizontalAlignment: Text.AlignHCenter
                                        maximumLineCount: 2   // prevent it from growing too tall
                                        elide: Text.ElideRight
                                        Layout.preferredWidth: parent.width - 40 // leave some padding
                                    }

                                    // Track artist
                                    Text {
                                        Layout.alignment: Qt.AlignCenter
                                        text: player.trackArtist || "Unknown Artist"
                                        font.pixelSize: 12
                                        color: "#cccccc"
                                        wrapMode: Text.Wrap   // wrap at word boundaries
                                        horizontalAlignment: Text.AlignHCenter
                                        maximumLineCount: 2
                                        elide: Text.ElideRight
                                        Layout.preferredWidth: parent.width - 40
                                    }
                                }

                                // Controls
                                ColumnLayout {
                                    Layout.alignment: Qt.AlignCenter
                                    spacing: 6

                                    RowLayout {
                                        Layout.alignment: Qt.AlignCenter
                                        spacing: 8

                                        Repeater {
                                            model: [
                                                { icon: "⏮", enabled: player.canGoPrevious, action: () => player.previous() },
                                                { icon: player.playbackState === 2 ? "⏸" : "▶", enabled: player.canTogglePlaying, action: () => player.togglePlaying() },
                                                { icon: "⏭", enabled: player.canGoNext, action: () => player.next() }
                                            ]
                                            delegate: Rectangle {
                                                width: 32; height: 32
                                                radius: 6
                                                color: modelData.enabled ? "#555" : "#333"
                                                opacity: modelData.enabled ? 1.0 : 0.4

                                                Text {
                                                    anchors.centerIn: parent
                                                    text: modelData.icon
                                                    font.pixelSize: 16
                                                    color: "white"
                                                }

                                                MouseArea {
                                                    anchors.fill: parent
                                                    enabled: modelData.enabled
                                                    onClicked: modelData.action()
                                                    hoverEnabled: true
                                                    onEntered: parent.color = "#777"
                                                    onExited: parent.color = modelData.enabled ? "#555" : "#333"
                                                }
                                            }
                                        }
                                    }

                                    Slider {
                                        Layout.alignment: Qt.AlignCenter
                                        id: posSlider
                                        Layout.preferredWidth: 220
                                        from: 0
                                        to: player.lengthSupported ? player.length : player.position
                                        value: player.position
                                        enabled: player.canSeek && player.positionSupported
                                        onMoved: player.position = value
                                    }

                                    FrameAnimation {
                                        running: playerPopup.visible 
                                        onTriggered: posSlider.value = player.position
                                    }
                                }
                            }

                            Timer {
                                interval: 1000
                                running: !playerPopup.visible 
                                repeat: true
                                onTriggered: posSlider.value = player.position
                            }
                        }
                    }
                }
            }
        }
    }
}

