import Quickshell
import QtQuick
import qs.config

FloatingWindow {
    id: fwindow
    title: "Popup"
    visible: false

    property alias active: fwindow.visible
}
