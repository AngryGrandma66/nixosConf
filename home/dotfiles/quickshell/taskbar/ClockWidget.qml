import QtQuick
import "../singletons" 
Text {
    id: clock
    text:  Qt.formatDateTime(Time.time, "hh:mm") 
    property bool date: false
    MouseArea {
        anchors.fill: parent
        onClicked: {
           clock.text = clock.date ? Qt.formatDateTime(Time.time, "hh:mm") :   Qt.formatDateTime(Time.time, "ddd MMM d hh:mm")
           clock.date = !clock.date
        }
    }
}
