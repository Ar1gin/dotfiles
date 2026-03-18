import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.config

PanelWindow {
    id: fwindow
    // title: "Popup"
    visible: false

    property alias active: fwindow.visible

    color: Colors.none
    exclusionMode: ExclusionMode.Ignore
    focusable: true

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "overview"
}
