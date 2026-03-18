import QtQuick
import qs.config

LabelText {
    id: counter

    required property real value
    property color foreground: Colors.foreground
    property color background: Colors.dimmer
    property string postfix: "%"
    property int preZeroes: 3
    property int postZeroes: 0
    text: "0".repeat(preZeroes) + (postZeroes > 0 ? "." : "") + "0".repeat(postZeroes) + " ".repeat(counter.postfix.length)
    color: background
    font: Constants.mainFont

    LabelText {
        property int padSize: counter.preZeroes + ((counter.postZeroes > 0) ? (counter.postZeroes + 1) : 0)
        horizontalAlignment: counter.horizontalAlignment
        verticalAlignment: counter.verticalAlignment

        anchors.fill: parent
        text: (counter.value).toFixed(counter.postZeroes).padStart(padSize, " ") + postfix
        font: parent.font
        color: counter.foreground

        fontSizeMode: counter.fontSizeMode
    }
}
