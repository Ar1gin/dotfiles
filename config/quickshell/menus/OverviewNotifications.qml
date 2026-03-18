import QtQuick
import QtQuick.Layouts
import qs
import qs.config
import qs.components

ColumnLayout {
    spacing: Constants.splitWidth

    Repeater {
        model: Notifications.list
        NotificationView {
            required property var modelData
            notification: modelData
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
