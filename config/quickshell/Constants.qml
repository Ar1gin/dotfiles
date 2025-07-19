pragma Singleton

import QtQml
import QtQuick

QtObject {
    readonly property real barHeight: 32
    readonly property real borderHeight: 2
    readonly property int textShadowOffset: 2

    readonly property font mainFont: ({
            family: "JetBrainsMono Nerd Font",
            pointSize: 14,
            hintingPreference: Font.PreferFullHinting
        })
    readonly property font smallFont: ({
            family: "JetBrainsMono Nerd Font",
            pointSize: 12.5,
            hintingPreference: Font.PreferFullHinting
        })
    readonly property font tinyFont: ({
            family: "JetBrainsMono Nerd Font",
            pointSize: 9,
            hintingPreference: Font.PreferFullHinting
        })
    readonly property font largeFont: ({
            family: "JetBrainsMono Nerd Font",
            pointSize: 24,
            hintingPreference: Font.PreferFullHinting
        })

    readonly property string dateFormat: "+%T / %A %d"
    readonly property int dateRefreshDelay: 1000

    readonly property int indicatorUpdateDelay: 2000
    readonly property int alertUpdateDelay: 5000

    readonly property real memAlertPercentage: 0.8
    readonly property real diskAlertPercentage: 0.8
    readonly property real batAlertPercentage: 0.15
}
