pragma Singleton

import QtQuick
import "themes" as Themes

QtObject {
    readonly property QtObject active: Themes.EmberNAsh

    readonly property color background: active.background
    readonly property color backgroundSecondary: active.backgroundSecondary

    readonly property color primary: active.primary
    readonly property color secondary: active.secondary

    readonly property color text: active.text
    readonly property color textMuted: active.textMuted

    readonly property color success: active.success
    readonly property color warning: active.warning
    readonly property color error: active.error

    readonly property string font: active.font
    readonly property string iconFont: active.iconFont
    readonly property real iconOpacity: active.iconOpacity

    readonly property int titleSize: active.titleSize
    readonly property int textSize: active.textSize
    readonly property int smallTextSize: active.smallTextSize

    readonly property int radius: active.radius
    readonly property int padding: active.padding

    readonly property real backgroundOpacity: active.backgroundOpacity
}