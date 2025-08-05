pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: wm

    property var workspaces: []

    NiriWM {
        onWorkspacesChanged: wm.workspaces = this.workspaces
    }
    HyprlandWM {
        onWorkspacesChanged: wm.workspaces = this.workspaces
    }
}
