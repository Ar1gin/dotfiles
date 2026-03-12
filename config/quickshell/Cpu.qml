pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
    readonly property real usage: 0.47
    property var profile: PowerProfiles.profile;
}
