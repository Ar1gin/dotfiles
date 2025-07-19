import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts

Item {
    id: music

    StackLayout {
        id: layout
        anchors.fill: parent
    }
    Repeater {
        model: Mpris.players
        Item {
            id: item
            required property var modelData
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: modelData.isPlaying
            parent: visible ? layout : music
            RowLayout {
                anchors.fill: parent
                anchors.topMargin: Constants.borderHeight * 2
                Image {
                    Layout.fillHeight: true
                    Layout.preferredWidth: height * 3
                    fillMode: Image.PreserveAspectCrop
                    smooth: true
                    mipmap: true
                    source: modelData.trackArtUrl
                }
                PText {
                    clip: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignLeft
                    color: Colors.foreground
                    font: Constants.smallFont
                    text: modelData.trackTitle
                    fontSizeMode: Text.HorizontalFit
                    minimumPointSize: height * 0.5
                }
            }
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                height: Constants.borderHeight
                color: Colors.background
                Rectangle {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: parent.width * (modelData.position / modelData.length)
                    color: Colors.musicBar
                }
            }
            Timer {
                running: item.modelData.playbackState == MprisPlaybackState.Playing
                interval: Math.max(1, parseInt(1000 * item.modelData.length / Math.max(music.width, 1) * 2))
                repeat: true
                onTriggered: item.modelData.positionChanged()
            }
        }
    }
    Rectangle {
        anchors.fill: parent
        visible: layout.children.length == 0
        color: Colors.workspaceButtonInactive
        border.width: Constants.borderHeight
        border.color: Colors.workspaceButtonInactiveBorder
        PText {
            anchors.fill: parent
            font: Constants.smallFont
            color: Colors.foregroundDim
            text: "~ No media playing ~"
        }
    }
}
