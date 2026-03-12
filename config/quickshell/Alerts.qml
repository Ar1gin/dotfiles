import QtQuick
import QtQuick.Layouts
import qs.config

Item {
    id: alerts
    RowLayout {
        anchors.fill: parent
        spacing: Constants.splitWidth
        AlertBox {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            severity: alerts.top1Alert?.[1] ?? 0
            text: alerts.top1Alert?.[0] ?? "ohh"
            opacity: alerts.top1Alert != null
        }
        AlertBox {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            severity: alerts.top2Alert?.[1] ?? 0
            text: alerts.top2Alert?.[0] ?? "ohh"
            opacity: alerts.top2Alert != null
        }
        AlertBox {
            Layout.fillHeight: true
            severity: alerts.leftAlertsSeverity
            icon: false
            text: "+" + alerts.leftAlerts.toString().padStart(2, "0")
            opacity: alerts.leftAlerts > 0
        }
    }

    property var alertList: [
        ["Offline", 2, !Net.online],
        ["Battery Low", 2, Battery.alert],
        ["Battery Critical", 3, !Battery.alert && Battery.critical],
        ["Storage Low", 2, false],
        ["Storage Critical", 3, false],
    ];
    property var top1Alert: null
    property var top2Alert: null
    property int leftAlertsSeverity: 0
    property int leftAlerts: 0

    onAlertListChanged: {
        top1Alert = null;
        top2Alert = null;
        leftAlertsSeverity = 0;
        leftAlerts = -2;
        // Expensive, yes. Frequent? Nah.
        for (var i = 0; i < alertList.length; i++) {
            const currAlert = alertList[i];
            if(!currAlert[2]) continue;
            leftAlerts += 1;

            if (top1Alert == null || top1Alert[1] < currAlert[1]) {
                if(top2Alert == null || top2Alert[1] <= top1Alert[1]) {
                    if(top2Alert != null && leftAlertsSeverity < top2Alert[1]) {
                        leftAlertsSeverity = top2Alert[1]
                    }
                    top2Alert = top1Alert;
                } else {
                    if(top1Alert != null && leftAlertsSeverity < top1Alert[1]) {
                        leftAlertsSeverity = top1Alert[1]
                    }
                }
                top1Alert = currAlert;
            } else {
                if(top2Alert == null || top2Alert[1] <= currAlert[1]) {
                    if(top2Alert != null && leftAlertsSeverity < top2Alert[1]) {
                        leftAlertsSeverity = top2Alert[1]
                    }
                    top2Alert = currAlert;
                } else {
                    if(leftAlertsSeverity < currAlert[1]) {
                        leftAlertsSeverity = currAlert[1]
                    }
                }
            }
        }
    }
}
