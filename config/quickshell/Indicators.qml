import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config

RowLayout {
    spacing: Constants.splitWidth
    Indicator {
        implicitWidth: 96
        Layout.maximumWidth: 96
        Layout.fillHeight: true
        icon: "cpu"
        value: Cpu.usage
        color: Colors.cpuAccent
    }
    Indicator {
        implicitWidth: 96
        Layout.maximumWidth: 96
        Layout.fillHeight: true
        icon: "memory"
        value: Ram.memUsage
        color: Colors.memAccent
    }
    Indicator {
        implicitWidth: 96
        Layout.maximumWidth: 96
        Layout.fillHeight: true
        icon: "drive-harddisk"
        value: Storage.usageRoot
        color: Colors.driveAccent
    }
    Indicator {
        visible: Battery.hasBattery
        implicitWidth: 96
        Layout.maximumWidth: 96
        Layout.fillHeight: true
        icon: "battery"
        lit: Battery.alert
        value: Battery.charge
        color: Battery.charging ? Colors.batAccentCharging : Colors.batAccentLow
    }
}
