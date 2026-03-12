pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import qs.config

Singleton {
    readonly property bool hasBattery: UPower.displayDevice.isLaptopBattery
    readonly property real charge: UPower.displayDevice.energy / UPower.displayDevice.energyCapacity
    readonly property bool alert: (UPower.displayDevice.timeToEmpty > 0 && charge < 0.10) || (UPower.displayDevice.timeToFull > 0 && charge > 0.9)
    readonly property bool critical: UPower.displayDevice.timeToEmpty > 0 && charge < 0.05
    readonly property bool charging: UPower.displayDevice.timeToFull > 0
    readonly property real time: charging ? UPower.displayDevice.timeToFull : UPower.displayDevice.timeToEmpty
    // readonly property bool hasBattery: true
    // readonly property real charge: 0.4
    // readonly property bool alert: false
    // readonly property bool critical: false
    // readonly property bool charging: true
    // readonly property real time: 60 * 60 * 23
}
