pragma Singleton

import Quickshell
import Quickshell.Services.Notifications

Singleton {
    readonly property var list: server.trackedNotifications
    NotificationServer {
        id: server
        onNotification: notification => {
            notification.tracked = true;
        }
    }
}
