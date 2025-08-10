import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../config"

RowLayout {
    required property var screen
    spacing: Constants.borderHeight
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: 1
        color: Colors.elementBackground
        Workspaces {
            anchors.fill: parent
            anchors.margins: Constants.borderHeight
        }
    }
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: 1
        color: Colors.elementBackground
        Alerts {
            anchors.fill: parent
            anchors.margins: Constants.borderHeight
        }
    }
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: 2
        color: Colors.elementBackground
        Clock {
            anchors.fill: parent
            anchors.margins: Constants.borderHeight
        }
    }
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: 1
        color: Colors.elementBackground
        Music {
            anchors.fill: parent
            anchors.margins: Constants.borderHeight
        }
    }
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: 1
        color: Colors.elementBackground
        Indicators {
            anchors.fill: parent
            anchors.margins: Constants.borderHeight
        }
    }
}
