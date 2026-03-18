pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: audio
    readonly property PwNode mic: Pipewire.defaultAudioSource
    readonly property PwNode spk: Pipewire.defaultAudioSink
    readonly property alias micLinks: micLinkTracker.linkGroups
    readonly property alias spkLinks: spkLinkTracker.linkGroups

    readonly property int recording: (!mic.audio.muted && micLinks.length > 0) ? micLinks.length : 0

    PwNodeLinkTracker {
        id: micLinkTracker
        node: audio.mic
    }
    PwNodeLinkTracker {
        id: spkLinkTracker
        node: audio.spk
    }

    PwObjectTracker {
        objects: [audio.mic, audio.spk]
    }
}
