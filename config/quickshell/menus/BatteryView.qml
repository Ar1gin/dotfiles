import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components
import qs

ViewRow {
    value: Battery.charge
    foreground: Colors.batAccentNormal

    LabelText {
        Layout.fillWidth: true
        text: Battery.charging ? "Charging" : "Discharging"
        horizontalAlignment: Text.AlignLeft
    }
    LabelText {
        Layout.fillWidth: true
        color: Colors.foregroundDim
        text: `${Constants.formatDuration(Battery.time)} until ${Battery.charging ? "full" : "empty"}`
        wrapMode: Text.WordWrap
        font: Constants.smallFont
        horizontalAlignment: Text.AlignLeft
    }
}
