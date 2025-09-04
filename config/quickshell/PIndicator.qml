import QtQuick
import QtQuick.Layouts
import "components"
import "config"

Rectangle {
    id: indicator

    required property color mainColor
    property color textColor: Colors.foreground
    required property string symbol
    required property real percentage
    property var patternSource: "pattern_alert.png"

    color: Colors.background
    border.width: Constants.borderHeight
    border.color: Colors.workspaceButtonInactiveBorder
    PText {
        anchors.fill: parent
        anchors.topMargin: Constants.borderHeight * 2
        anchors.bottomMargin: Constants.borderHeight * 2
        font: Constants.tinyFont
        color: indicator.textColor
        text: parseInt(100 * indicator.percentage) + "% " + indicator.symbol
    }
    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: Constants.borderHeight
        height: Constants.borderHeight
        color: Colors.background
    }
    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: Constants.borderHeight
        color: Colors.workspaceButtonActiveBorder
        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: parent.width * indicator.percentage
            color: indicator.mainColor
        }
    }
}
