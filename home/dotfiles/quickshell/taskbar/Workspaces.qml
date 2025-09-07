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

    // Return biggest window (by pixel area) for a given workspace ID
    // Return the 4 biggest windows (by pixel area) for a given workspace ID
    function biggestWindowsForWorkspace(workspaceId) {

        return windowsForWorkspace(workspaceId)
        .slice(0, 4); // take the top 4
    }
    function windowsForWorkspace(workspaceId) {
        const windows = windowList.filter(w => w.workspace.id === workspaceId);

        return windows
        .sort((a, b) => {
            const areaA = (a?.size?.[0] ?? 0) * (a?.size?.[1] ?? 0);
            const areaB = (b?.size?.[0] ?? 0) * (b?.size?.[1] ?? 0);
            return areaB - areaA; // sort descending
        })
    }

    // Guess icon based on class name
    function iconExists(iconName) {
        if (!iconName || iconName.length === 0) return false
        const result = Quickshell.iconPath(iconName, true)
        return result.length > 0 && !result.includes("image-missing")
    }

    function guessIcon(className) {
        if (!className || className.length === 0) return "image-missing"

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
    //update all popup positons on change
    /*    function updatePopups(){
         for (let p of allPopups) {
             p.visible = !p.visible
             p.visible = !p.visible
         }
     }
     onWidthChanged: updatePopups()
     */
    property var urgentWindowAddresses: []
    // Auto-refresh on Hyprland events
    Connections {
        target: Hyprland
        function onRawEvent(ev) {
            updateWindowList()
            if (ev.name ==="urgent"){
                console.log(ev.data)
                urgentWindowAddresses.push(ev.data)

            }
        }
    }
    Component.onCompleted:{ 
        updateWindowList()
    }
    // This Repeater keeps only urgent windows

    Process {
        id: getClients
        command: ["bash", "-c", "hyprctl clients -j"]
        stdout: StdioCollector {
            onStreamFinished: {
                workspacesRow.windowList = JSON.parse(text)

            }
        }
    }
    // Returns true if ANY window in the workspace is urgent
    function normalizeWindowAddress(addr) {
        if (typeof addr === "string" && addr.startsWith("0x")) {
            return addr.slice(2)
        }
        return addr
    }

    // Returns true if any window in workspace is urgent
    function isWorkspaceUrgent(workspaceId) {
        return windowsForWorkspace(workspaceId).some(window =>
        urgentWindowAddresses.includes(normalizeWindowAddress(window.address)))
    }

    // Returns all urgent windows for a workspace
    function getUrgentWindowsForWorkspace(workspaceId) {
        return windowsForWorkspace(workspaceId)
        .map(w => normalizeWindowAddress(w.address))
        .filter(addr => urgentWindowAddresses.includes(addr))
    }

    // Returns true if this specific window is urgent
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

        // Remove each urgent window of this workspace from the main list
        urgentWindowAddresses = urgentWindowAddresses.filter(
            addr => !urgentWindows.includes(addr)
        );
    }

    // Workspaces display
    Repeater {
        id: workspaceRepeater
        model:Hyprland.workspaces 
        Rectangle {
            // Base icon size and spacing
            id: workspaceButton
            property int iconSize:20
            property int iconSpacing: 5
            property int popupHeaderHeight: 25
            property int popupWidth: 500
            property int popupHeight: (popupWidth * (resolutionHeight/resolutionWidth)) + popupHeaderHeight
            property var topWindows: biggestWindowsForWorkspace(modelData.id)
            property var workspaceUrgencyStatus 
            // Dynamic width based on number of windows + space for number
            width: (topWindows.length + 1) * (iconSize + iconSpacing)
            height: 25
            radius: 10
            color: modelData.active ? "#4a9eff" : (isWorkspaceUrgent(modelData.id) ? "#ff5555" : "#333333")
            border.color: "#555555"
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
            }            // Row with workspace number + icons
            Row {
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                spacing: iconSpacing
                // Workspace number
                Text {
                    text: modelData.id
                    color: modelData.active ? "#ffffff" : "#cccccc"
                    font.pixelSize: 12
                    anchors.verticalCenter: parent.verticalCenter  // center vertically
                }

                PopupWindow {
                    id: workspacePopup
                    property var windowsForThisPopup: windowsForWorkspace(modelData.id)
                    property real scaleX: popupWidth/ resolutionWidth
                    property real scaleY: (popupHeight-popupHeaderHeight)/ resolutionHeight

                    anchor.window: topBar
                    anchor.rect.x: workspacesRow.parent.x+  workspaceButton.x + workspaceButton.width / 2 -popupWidth/2
                    anchor.rect.y: parentWindow.height
                    implicitWidth: popupWidth
                    implicitHeight: popupHeight
                    visible: false
                    Component.onCompleted: {
                        allPopups.push(this)
                    }
                    Component.onDestruction: {
                        allPopups.splice(allPopups.indexOf(this), 1)
                    }
                    onVisibleChanged: if (visible) anchor.updateAnchor()


                    Column {
                        anchors.fill: parent
                        spacing: 0

                        // header

                        Rectangle {
                            width: parent.width
                            height: popupHeaderHeight

                            color: "#222222"
                            Text {
                                anchors.centerIn: parent
                                text: "Workspace: " + modelData.id
                                font.pixelSize: 14
                                color: "#ffffff"
                            }
                        }
                        // windows layout container
                        Item {
                            id: windowsContainer
                            width: parent.width
                            y : popupHeaderHeight 

                            Repeater {
                                model: workspacePopup.windowsForThisPopup
                                Rectangle {
                                    color: modelData.focusHistoryID === 0 ? "#4a9eff" : (isWindowUrgent(modelData.address) ? "#ff5555" : "#333333")
                                    border.color: "#222222"
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

                                        // App icon
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

                                        // Window title that adapts font size
                                        Text {
                                            id: titleText
                                            text: modelData.title || "Untitled"
                                            color: "#ffffff"
                                            wrapMode: Text.WordWrap
                                            horizontalAlignment: Text.AlignHCenter
                                            width: content.width

                                            // Start with large size
                                            font.pixelSize: Math.min(content.height * 0.2, 24)

                                            // Shrink dynamically if text overflows height
                                            Component.onCompleted: adjustFontSize()
                                            onTextChanged: adjustFontSize()
                                            onWidthChanged: adjustFontSize()

                                            function adjustFontSize() {
                                                var maxHeight = content.height * 0.5   // reserve half for text
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
                // Icons
                Repeater {
                    model: topWindows

                    ShaderEffectSource {
                        id: svgSource
                        sourceItem: Image {
                            source: Quickshell.iconPath(
                                guessIcon(modelData?.appID || modelData?.initialClass || modelData?.class)
                                , "image-missing"
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

    // Fallback message
    Text {
        visible: Hyprland.workspaces.length === 0
        text: "No workspaces"
        color: "#ffffff"
        font.pixelSize: 12
    }
}

