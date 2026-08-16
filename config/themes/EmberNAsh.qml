pragma Singleton

import QtQuick

QtObject {
    readonly property color background: "#1a1a1a"
    readonly property color backgroundSecondary: "#222222"

    readonly property color primary: "#ff884d"
    readonly property color secondary: "#e5d6c6"

    readonly property color text: "#e5d6c6"
    readonly property color textMuted: "#8f8175"

    readonly property color success: "#7cb37f"
    readonly property color warning: "#e0af68"
    readonly property color error: "#f7768e"

    readonly property string font: "JetBrainsMono Nerd Font"
    readonly property string iconFont: "JetBrainsMono Nerd Font"
    readonly property real iconOpacity: 0.75
    
    readonly property int titleSize: 18
    readonly property int textSize: 14
    readonly property int smallTextSize: 12

    readonly property int radius: 6
    readonly property int padding: 18

    readonly property real backgroundOpacity: 0.6
}