import QtQuick
import QtQuick.Layouts
import "../components"
import "../config"

RowLayout {
    Rectangle {
        color: Colors.background
        border.width: Constants.borderHeight
        border.color: color.lighter(1.25)
        Layout.fillWidth: true
        Layout.fillHeight: true
        PatternRect {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            property real mult: 1.0 / (24 * 3600)
            implicitWidth: parseInt(parent.width * Time.secondsSinceMidnight * mult)

            mainColor: Colors.clockBarNoonBorder
            secondaryColor: Colors.clockBarNoon
            borderWidth: Constants.borderHeight
            patternSource: "../assets/pattern_day.png"
        }
        PText {
            font: Constants.mainFont
            color: Colors.clockText
            text: Time.timeDisplay
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
