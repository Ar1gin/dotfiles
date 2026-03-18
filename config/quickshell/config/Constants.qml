pragma Singleton

import Quickshell
import QtQuick

Singleton {
    /// Delay between updates for indicators in milliseconds
    readonly property int updateDelay: 1000

    /// Controls the height of the bar
    readonly property real barHeight: 40
    readonly property real barBorderWidth: 2
    readonly property real barBorderRadius: 4

    /// Controls the width of every layout split and several split-sized elements
    readonly property real splitWidth: 4

    readonly property real splitWidthLarge: 24

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

    function lerpColor(a: color, b: color, factor: real): color {
        if(factor == 0) return a;
        if(factor == 1) return b;

        const fac1 = 1 - factor;
        return Qt.hsva(
            a.hsvHue        * fac1 + b.hsvHue        * factor,
            a.hsvSaturation * fac1 + b.hsvSaturation * factor,
            a.hsvValue      * fac1 + b.hsvValue      * factor,
            a.a *             fac1 + b.a             * factor,
        );
    }

    readonly property real mT: 0.0009765625
    readonly property real mTT: mT * mT
    readonly property real mTTT: mTT * mT
}
