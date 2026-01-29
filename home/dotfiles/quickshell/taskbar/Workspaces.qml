// Works
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
Row {
    id: workspacesRow
    spacing: 5
    property int resolutionWidth : 1920
    property int resolutionHeight: 1200


    // State variables
    property var windowList: []

    // Update window list from Hyprland clients
    function updateWindowList() {
        getClients.running = true
    }

    // Return the 4 biggest windows (by pixel area) for a given workspace ID
    function biggestWindowsForWorkspace(workspaceId) {
        return windowsForWorkspace(workspaceId).slice(0, 4)
    }

    function windowsForWorkspace(workspaceId) {
        const windows = windowList.filter(w => w.workspace.id === workspaceId);
        return windows.sort((a, b) => {
            const areaA = (a?.size?.[0] ?? 0) * (a?.size?.[1] ?? 0);
            const areaB = (b?.size?.[0] ?? 0) * (b?.size?.[1] ?? 0);
            return areaB - areaA;
        })
    }

    // Guess icon Theme.based on class name
    function iconExists(iconName) {
        if (!iconName || iconName.length === 0) return false
        const result = Quickshell.iconPath(iconName, true)
        return result.length > 0 && !result.includes("image-missing")
    }


    function guessIcon(className) {
        if (!className || className.length === 0) return "image-missing"

        const iconSubstitutions = {
            "jetbrains-idea": "idea-ultimate",
            "jetbrains-phpstorm": "phpstorm",
            "jetbrains-pycharm": "pycharm-professional",
            "jetbrains-webstorm": "webstorm",
            "jetbrains-clion": "clion"
        }
        if (iconSubstitutions[className]) {
            const subIcon = iconSubstitutions[className]
            if (iconExists(subIcon)) return subIcon
        }

        if(iconExists(className)) return className

        const lower = className.toLowerCase()
        if (iconExists(lower)) return lower

        const kebab = lower.replace(/\s+/g, "-")
        if (iconExists(kebab)) return kebab

        const domain = className.split('.').slice(-1)[0]
        if (iconExists(domain)) return domain




        console.log(`⚠️ [guessIcon] No icon found for '${className}', using fallback.`)
        return "application-x-executable"
    }

    property var urgentWindowAddresses: []

    Connections {
        target: Hyprland
        function onRawEvent(ev) {
            updateWindowList()
            if (ev.name ==="urgent"){
                urgentWindowAddresses.push(ev.data)
            }
        }
    }

    Component.onCompleted:{ 
        updateWindowList()
    }

    Process {
        id: getClients
        command: ["bash", "-c", "hyprctl clients -j"]
        stdout: StdioCollector {
            onStreamFinished: {
                workspacesRow.windowList = JSON.parse(text)
            }
        }
    }
    function fullscreenWindowsForWorkspace(workspaceId) {
        const windows = windowsForWorkspace(workspaceId)
        if (windows.length > 0 && windows[0].fullscreen === 2) {
            return [windows[0]]
        }
        return windows
    }
    function normalizeWindowAddress(addr) {
        if (typeof addr === "string" && addr.startsWith("0x")) {
            return addr.slice(2)
        }
        return addr
    }

    function isWorkspaceUrgent(workspaceId) {
        return windowsForWorkspace(workspaceId).some(window =>
        urgentWindowAddresses.includes(normalizeWindowAddress(window.address)))
    }

    function getUrgentWindowsForWorkspace(workspaceId) {
        return windowsForWorkspace(workspaceId)
        .map(w => normalizeWindowAddress(w.address))
        .filter(addr => urgentWindowAddresses.includes(addr))
    }

    function isWindowUrgent(windowAddress) {
        return urgentWindowAddresses.includes(normalizeWindowAddress(windowAddress))
    }

    property var allPopups: []

    function showPopupFor(targetPopup) {
        for (let p of allPopups) {
            p.visible = (p === targetPopup)
        }
    }

    function clearUrgentForWorkspace(workspaceId) {
        const urgentWindows = getUrgentWindowsForWorkspace(workspaceId);
        urgentWindowAddresses = urgentWindowAddresses.filter(
            addr => !urgentWindows.includes(addr)
        )
    }

    // Workspaces display
    Repeater {
        id: workspaceRepeater
        model:Hyprland.workspaces 
        Rectangle {
            id: workspaceButton
            property int iconSize:20
            property int iconSpacing: 5
            property int popupHeaderHeight: 25
            property int popupWidth: 500
            property int popupHeight: (popupWidth * (resolutionHeight/resolutionWidth)) + popupHeaderHeight
            property var topWindows: biggestWindowsForWorkspace(modelData.id)
            property var workspaceUrgencyStatus 

            width: (topWindows.length + 1) * (iconSize + iconSpacing)
            height: 25
            radius: 10
            color: modelData.active ? Theme.base02 : (isWorkspaceUrgent(modelData.id) ? Theme.base09 : Theme.base00)
            border.color: Theme.base01
            border.width: 1

            onColorChanged: {
                if(modelData.active){ 
                    clearUrgentForWorkspace(modelData.id)
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: showPopupFor(workspacePopup)
                onExited: workspacePopup.visible = false
                onClicked: {
                    Hyprland.dispatch("workspace " + modelData.id)
                }
            }

            Row {
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                spacing: iconSpacing

                Text {
                    text: modelData.id
                    color: modelData.active ? Theme.base05 : Theme.base04
                    font.pixelSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                }

                PopupWindow {
                    id: workspacePopup
                    property var windowsForThisPopup:fullscreenWindowsForWorkspace(modelData.id)

                    property real scaleX: popupWidth/ resolutionWidth
                    property real scaleY: (popupHeight-popupHeaderHeight)/ resolutionHeight

                    anchor.window: topBar
                    anchor.rect.x: workspacesRow.parent.x+  workspaceButton.x + workspaceButton.width / 2 -popupWidth/2
                    anchor.rect.y: parentWindow.height
                    implicitWidth: popupWidth
                    implicitHeight: popupHeight
                    visible: false
                    Component.onCompleted: allPopups.push(this)
                    Component.onDestruction: allPopups.splice(allPopups.indexOf(this), 1)
                    onVisibleChanged: if (visible) anchor.updateAnchor()

                    Column {
                        anchors.fill: parent
                        spacing: 0

                        Rectangle {
                            width: parent.width
                            height: popupHeaderHeight
                            color: Theme.base01

                            Text {
                                anchors.centerIn: parent
                                text: "Workspace: " + modelData.id
                                font.pixelSize: 14
                                color: Theme.base05
                            }
                        }

                        Item {
                            id: windowsContainer
                            width: parent.width
                            y : popupHeaderHeight 

                            Repeater {
                                model: workspacePopup.windowsForThisPopup
                                Rectangle {
                                    color: modelData.focusHistoryID === 0 ? Theme.base02 : (isWindowUrgent(modelData.address) ? Theme.base09 : Theme.base00)
                                    border.color: Theme.base01
                                    border.width: 1
                                    radius: 3

                                    x: modelData.at[0] * workspacePopup.scaleX
                                    y: modelData.at[1] * workspacePopup.scaleY
                                    width: modelData.size[0] * workspacePopup.scaleX
                                    height: modelData.size[1] * workspacePopup.scaleY

                                    Column {
                                        id: content
                                        anchors.centerIn: parent
                                        spacing: 6
                                        width: parent.width * 0.9
                                        height: parent.height * 0.9

                                        Image {
                                            id: icon
                                            source: Quickshell.iconPath(
                                                guessIcon(modelData?.appID || modelData?.initialClass || modelData?.class),
                                                "image-missing"
                                            )
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            fillMode: Image.PreserveAspectFit
                                            width: Math.min(content.width, content.height) * 0.5
                                            height: width
                                        }

                                        Text {
                                            id: titleText
                                            text: modelData.title || "Untitled"
                                            color: Theme.base05
                                            wrapMode: Text.WordWrap
                                            horizontalAlignment: Text.AlignHCenter
                                            width: content.width
                                            font.pixelSize: Math.min(content.height * 0.2, 24)

                                            Component.onCompleted: adjustFontSize()
                                            onTextChanged: adjustFontSize()
                                            onWidthChanged: adjustFontSize()

                                            function adjustFontSize() {
                                                var maxHeight = content.height * 0.5
                                                while (implicitHeight > maxHeight && font.pixelSize > 8) {
                                                    font.pixelSize -= 1
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Repeater {
                    model: topWindows
                    ShaderEffectSource {
                        id: svgSource
                        sourceItem: Image {
                            source: Quickshell.iconPath(
                                guessIcon(modelData?.appID || modelData?.initialClass || modelData?.class),
                                "image-missing"
                            )
                            width: 32
                            height: 32
                        }
                        width: iconSize
                        height: iconSize
                        live: true
                        smooth: true
                    }
                }
            }
        }
    }

    Text {
        visible: Hyprland.workspaces.length === 0
        text: "No workspaces"
        color: Theme.base05
        font.pixelSize: 12
    }
}

