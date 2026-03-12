import QtQuick
import qs.config

CircleBar {
    id: bar
    end: 1 - gap
    offset: gap * 0.5
    clockwise: true
    property real gap: Math.asin(Math.min(1, (counter.height + Constants.splitWidth * 2) / bar.height)) / Math.PI

    Counter {
        id: counter
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.5 - parent.radius
        value: bar.value * 100
        foreground: bar.foreground
        font: Constants.largeFont
    }
}
