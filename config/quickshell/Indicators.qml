import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import "config"

RowLayout {
    spacing: Constants.borderHeight
    PIndicator {
        Layout.fillWidth: true
        Layout.fillHeight: true

        mainColor: Colors.indicatorBattery
        symbol: ""
        percentage: 0.5
    }
    PIndicator {
        Layout.fillWidth: true
        Layout.fillHeight: true

        mainColor: Colors.indicatorRam
        symbol: "󰍛"
        percentage: Ram.memUsage
    }
    PAudio {
        Layout.fillWidth: true
        Layout.fillHeight: true
        node: Pipewire.defaultAudioSource
        activeColor: Colors.indicatorMic
        inactiveText: "OFF 󰍭"
        activeText: "REC 󰍬"
    }
    PAudio {
        Layout.fillWidth: true
        Layout.fillHeight: true
        node: Pipewire.defaultAudioSink
        activeColor: Colors.indicatorSpeaker
        inactiveText: "OFF 󰝟"
        activeText: "SPK 󰕾"
    }
}
