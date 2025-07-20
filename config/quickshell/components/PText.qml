import QtQuick.Effects
import QtQuick
import "../config"

// Fixed text

Text {
    id: ptext

    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    renderType: Text.NativeRendering
    Text {
        id: ctext
        renderType: Text.NativeRendering
        visible: ptext.visible
        horizontalAlignment: ptext.horizontalAlignment
        verticalAlignment: ptext.verticalAlignment
        fontSizeMode: ptext.fontSizeMode
        minimumPointSize: ptext.minimumPointSize
        text: ptext.text
        anchors.fill: ptext
        font: ptext.font
        color: ptext.color
        layer.enabled: visible
        layer.effect: MultiEffect {
            source: ctext
            anchors.fill: ctext
            shadowEnabled: true
            shadowBlur: 0.5
            shadowVerticalOffset: Constants.textShadowOffset
            shadowColor: Colors.textShadow
            z: -1
        }
    }
}
