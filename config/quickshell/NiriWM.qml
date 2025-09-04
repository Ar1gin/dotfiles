import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    id: niri
    property var workspaces

    property var workspaceMap: new Map()
    property var windowMap: new Map()
    property var focusedWorkspace: null

    Process {
        id: ipc
        command: ["niri", "msg", "-j", "event-stream"]
        running: true
        stdout: SplitParser {
            onRead: function (json_data) {
                const data = JSON.parse(json_data);
                for(const msg in data) {
                    switch(msg) {
                        case "WorkspacesChanged":
                            const workspaces = data.WorkspacesChanged.workspaces;
                            var new_workspace_map = new Map();
                            var new_workspaces = [];
                            for (var i = 0; i < workspaces.length; i++) {
                                const workspace = workspaces[i];
                                new_workspace_map.set(workspace.id, {
                                    "index": workspace.idx - 1,
                                    "focused_window": workspace.active_window_id
                                });
                                const window = niri.windowMap.get(workspace.active_window_id);
                                new_workspaces[workspace.idx - 1] = {
                                    "focused": workspace.is_active,
                                    "name": workspace.name || "+",
                                    "icon": window != undefined ? window["app_id"] : null,
                                };
                                if (workspace.is_active) {
                                    niri.focusedWorkspace = workspace.id;
                                }
                            }
                            niri.workspaceMap = new_workspace_map;
                            niri.workspaces = new_workspaces;
                            break;
                        case "WorkspaceActivated":
                            const new_id = data.WorkspaceActivated.id;
                            if (niri.focusedWorkspace != null) {
                                niri.workspaces[niri.workspaceMap.get(niri.focusedWorkspace).index]["focused"] = false;
                            }
                            niri.workspaces[niri.workspaceMap.get(new_id).index]["focused"] = true;
                            niri.focusedWorkspace = new_id;
                            niri.workspaces = niri.workspaces;
                            break;
                        case "WindowsChanged":
                            const windows = data.WindowsChanged.windows;
                            var new_window_map = new Map();
                            for (var i = 0; i < windows.length; i++) {
                                const window = windows[i];
                                new_window_map.set(window.id, {
                                    "app_id": window.app_id
                                });
                            }
                            for (const [id, workspace] of niri.workspaceMap) {
                                if(workspace.focused_window != null) {
                                    niri.workspaces[workspace.index]["icon"] = new_window_map.get(workspace.focused_window)["app_id"];
                                } else {
                                    niri.workspaces[workspace.index]["icon"] = null
                                }
                            }
                            niri.workspaces = niri.workspaces;
                            niri.windowMap = new_window_map;
                            break;
                        case "WindowOpenedOrChanged":
                            const window = data.WindowOpenedOrChanged.window;
                            if(!niri.windowMap.has(window.id)) {
                                niri.windowMap.set(window.id, {
                                    "app_id": window.app_id
                                });
                            }
                            break;
                        case "WindowClosed":
                            niri.windowMap.delete(data.WindowClosed.id);
                            break;
                        case "WorkspaceActiveWindowChanged":
                            var new_icon = null;
                            const window_id = data.WorkspaceActiveWindowChanged.active_window_id;
                            if(window_id != null) {
                                new_icon = niri.windowMap.get(window_id)["app_id"];
                            }
                            niri.workspaces[niri.workspaceMap.get(data.WorkspaceActiveWindowChanged.workspace_id).index].icon = new_icon;
                            niri.workspaces = niri.workspaces;
                            break;
                    }
                }
            }
        }
    }
}
