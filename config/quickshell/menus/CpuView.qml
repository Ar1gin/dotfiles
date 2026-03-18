import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components
import qs

ViewCell {
    Keys.onPressed: event => {
        if(event.key == Qt.Key_Up) {
            if(Cpu.hasPerformanceProfile && PowerProfiles.profile < PowerProfile.Performance) {
                PowerProfiles.profile += 1;
            }
            if(!Cpu.hasPerformanceProfile && PowerProfiles.profile < PowerProfile.Balanced) {
                PowerProfiles.profile += 1;
            }
        }
        if(event.key == Qt.Key_Down && PowerProfiles.profile > PowerProfile.PowerSaver) {
            PowerProfiles.profile -= 1;
        }
    }

    value: Cpu.usage
    foreground: Colors.cpuAccent
    ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        spacing: Constants.splitWidth
        Icon {
            Layout.fillHeight: true
            implicitWidth: height
            path: "battery-profile-performance"
            color: Cpu.profile == PowerProfile.Performance ? Colors.cpuAccent : Colors.dimmer
            Icon {
                visible: !Cpu.hasPerformanceProfile
                anchors.fill: parent
                path: "lock"
                color: Colors.foregroundDim
            }
        }
        Icon {
            Layout.fillHeight: true
            implicitWidth: height
            path: "battery-profile-balanced"
            color: Cpu.profile == PowerProfile.Balanced ? Colors.cpuAccent : Colors.dimmer
        }
        Icon {
            Layout.fillHeight: true
            implicitWidth: height
            path: "battery-profile-powersave"
            color: Cpu.profile == PowerProfile.PowerSaver ? Colors.cpuAccent : Colors.dimmer
        }
    }
    VerticalText {
        Layout.fillHeight: true
        label.text: ["Power Saver", "Balanced", "Performance"][Cpu.profile]
        label.color: Colors.foregroundDim
    }
}
