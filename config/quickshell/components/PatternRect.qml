import QtQuick
import QtQuick.Effects
import "../config"

Rectangle {
    id: prect

    required property color mainColor
    required property color secondaryColor
    required property real borderWidth
    required property string patternSource
    property int patternWidth: this.width

    clip: false
    border.width: Constants.borderHeight
    color: secondaryColor

    Image {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        source: prect.patternSource
        width: prect.width
        fillMode: Image.Tile
        mipmap: false
        smooth: false
        horizontalAlignment: Image.AlignLeft
        verticalAlignment: Image.AlignTop

        layer.enabled: true
        layer.effect: MultiEffect {
            colorization: 1
            contrast: -0.75
            colorizationColor: prect.mainColor
        }
    }
    Rectangle {
        anchors.fill: parent
        color: Colors.none
        border.color: prect.mainColor
        border.width: prect.borderWidth
    }
}
