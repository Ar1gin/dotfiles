pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.Mpris
import qs.config
import qs.components

ViewRect {
    id: media
    property int currentPlayerIndex: 0
    property var currentPlayer: Mpris.players.values.length > currentPlayerIndex ? Mpris.players.values[currentPlayerIndex] : null
    property var streaming: !((currentPlayer?.lengthSupported ?? false) && (currentPlayer?.positionSupported ?? false))

    Keys.onPressed: event => {
        if (event.key == Qt.Key_Space && event.modifiers & Qt.ShiftModifier) {
            for (var i = 0; i < Mpris.players.values.length; i++) {
                Mpris.players.values[i].pause();
            }
            return;
        }
        if (currentPlayer != null && event.key == Qt.Key_Left && event.modifiers & Qt.ShiftModifier) {
            currentPlayer.previous();
            return;
        }
        if (currentPlayer != null && event.key == Qt.Key_Right && event.modifiers & Qt.ShiftModifier) {
            currentPlayer.next();
            return;
        }

        if (event.key == Qt.Key_Right && currentPlayerIndex + 1 < Mpris.players.values.length) {
            currentPlayerIndex += 1;
            return;
        }
        if (event.key == Qt.Key_Left && currentPlayerIndex > 0) {
            currentPlayerIndex -= 1;
            return;
        }

        if (currentPlayer == null)
            return;

        if (event.key == Qt.Key_Space) {
            currentPlayer.togglePlaying();
        }
    }
    Component.onCompleted: {
        Mpris.players.valuesChanged.connect(indexCheck);
    }

    function indexCheck() {
        if (currentPlayerIndex >= Mpris.players.values.length && currentPlayerIndex > 0) {
            currentPlayerIndex = Mpris.players.values.length - 1;
        }
    }

    ColumnLayout {
        visible: media.currentPlayer != null
        anchors.fill: parent
        anchors.margins: Constants.splitWidthLarge
        spacing: Constants.splitWidthLarge
        RowLayout {
            Layout.preferredHeight: 1
            spacing: Constants.splitWidthLarge
            Item {
                Layout.fillWidth: true
            }
            Repeater {
                model: Mpris.players
                Icon {
                    id: icon
                    required property var modelData
                    required property var index
                    implicitWidth: Constants.splitWidthLarge * 2
                    implicitHeight: Constants.splitWidthLarge * 2
                    path: modelData.desktopEntry
                    Rectangle {
                        visible: media.currentPlayerIndex == icon.index
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.bottom
                        anchors.topMargin: Constants.splitWidth
                        height: Constants.splitWidth
                        radius: height
                        color: Colors.foreground
                    }
                }
            }
            Item {
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Layout.preferredHeight: 4
            spacing: Constants.splitWidthLarge
            Image {
                id: img
                Layout.fillHeight: true
                Layout.fillWidth: true
                visible: media.currentPlayer != null && media.currentPlayer.trackArtUrl != ""
                source: media.currentPlayer.trackArtUrl
                fillMode: Image.PreserveAspectFit
            }
            Item {
                visible: !img.visible
                Layout.fillWidth: true
                Layout.fillHeight: true
                ViewRect {
                    anchors.centerIn: parent
                    height: parent.height
                    width: Math.min(parent.width, height)
                }

                LabelText {
                    anchors.fill: parent
                    color: Colors.foregroundDim
                    text: "No image provided"
                }
            }
        }
        ProgBar {
            id: bar
            Layout.fillWidth: true
            Layout.leftMargin: Constants.splitWidthLarge
            Layout.rightMargin: Constants.splitWidthLarge
            implicitHeight: Constants.splitWidth
            value: streaming ? 1 : currentPlayer.position / currentPlayer.length
            Rectangle {
                color: parent.fgColor
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: parent.value * parent.width + width * -0.5
                width: Constants.splitWidthLarge
                height: Constants.splitWidthLarge
                radius: width
            }
            Timer {
                running: currentPlayer.playbackState == MprisPlaybackState.Playing && !streaming
                interval: Math.min(Math.max(1, parseInt(1000 * currentPlayer.length / Math.max(bar.width, 1))), 1000 * 60)
                repeat: true
                onTriggered: currentPlayer.positionChanged()
            }
        }
        ColumnLayout {
            spacing: 0
            LabelText {
                Layout.fillWidth: true
                text: media.currentPlayer?.trackTitle ?? "Unknown"

                fontSizeMode: Text.HorizontalFit
            }
            LabelText {
                Layout.fillWidth: true
                text: media.currentPlayer?.trackArtist ?? "Unknown"
                color: Colors.foregroundDim

                fontSizeMode: Text.HorizontalFit
            }
        }
        RowLayout {
            spacing: Constants.splitWidthLarge
            Item {
                Layout.fillWidth: true
            }
            Icon {
                implicitWidth: Constants.splitWidthLarge * 2
                implicitHeight: Constants.splitWidthLarge * 2
                path: "media-skip-backward"
                color: Colors.foreground
            }
            Icon {
                implicitWidth: Constants.splitWidthLarge * 3
                implicitHeight: Constants.splitWidthLarge * 3
                path: currentPlayer.isPlaying ? "media-playback-pause" : "media-playback-start"
                color: Colors.foreground
            }
            Icon {
                implicitWidth: Constants.splitWidthLarge * 2
                implicitHeight: Constants.splitWidthLarge * 2
                path: "media-skip-forward"
                color: Colors.foreground
            }
            Item {
                Layout.fillWidth: true
            }
        }
    }
}
