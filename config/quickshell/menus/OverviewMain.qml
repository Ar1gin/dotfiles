import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components
import qs

GridLayout {
    Keys.forwardTo: [cpu]
    columns: 4
    rowSpacing: Constants.splitWidth
    columnSpacing: Constants.splitWidth
    DiskView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.columnSpan: 2
        Layout.rowSpan: 1
        Layout.preferredWidth: 2
    }
    UsageView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.columnSpan: 2
        Layout.rowSpan: 3
        Layout.preferredWidth: 2
    }
    CpuView {
        id: cpu
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: 1
    }
    MemView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: 1
    }
    BatteryView {
        visible: Battery.hasBattery
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.columnSpan: 2
        Layout.preferredWidth: 2
    }
    ViewRect {
        visible: !Battery.hasBattery
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.columnSpan: 2
        Layout.preferredWidth: 2
    }
}
