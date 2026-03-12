import QtQuick
import QtQuick.Layouts
import qs.config

RowLayout {
    id: counter
    required property real used
    required property real total
    property color foreground: Colors.foreground
    property color background: Colors.dimmer

    Layout.fillWidth: false

    spacing: 0
    ByteCounter {
        bytes: counter.used
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignRight
        level: c2.level
        foreground: counter.foreground
        background: counter.background
    }
    LabelText {
        text: "/"
        color: Colors.foreground
        opacity: 0.5
    }
    ByteCounter {
        id: c2
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignLeft
        bytes: counter.total
        foreground: counter.foreground
        background: counter.background
    }
}
