pragma Singleton

import Quickshell
import QtQuick

Singleton {
    /// Delay between updates for indicators in milliseconds
    readonly property int updateDelay: 1000

    /// Controls the height of the bar
    readonly property real barHeight: 40
    readonly property real barBorderWidth: 2

    /// Controls the width of every layout split and several split-sized elements
    readonly property real splitWidth: 4

    /// Controls radius of many rounded elements, set to zero to disable rounded edges
    readonly property real radius: 2

    readonly property font largeFont: ({
            family: "JetBrains Mono",
            pointSize: 24,
            hintingPreference: Font.PreferFullHinting
        })

    readonly property font mainFont: ({
            family: "JetBrains Mono",
            pointSize: 18,
            hintingPreference: Font.PreferFullHinting
        })

    readonly property font smallFont: ({
            family: "JetBrains Mono",
            pointSize: 14,
            hintingPreference: Font.PreferFullHinting
        })

    readonly property var alertIcon: [
        "dialog-information",
        "dialog-question",
        "dialog-warning",
        "dialog-error",
    ]

    function formatDuration(seconds: real): string {
        const secInt = parseInt(seconds);
        const minutes = (secInt / 60) >> 0;
        const hours = (minutes / 60) >> 0;
        if(hours > 0) {
            return `${hours} hours, ${minutes % 60} minutes`;
        }
        return `${minutes} minutes`;
    }

    readonly property real mT: 0.0009765625
    readonly property real mTT: mT * mT
    readonly property real mTTT: mTT * mT
}
