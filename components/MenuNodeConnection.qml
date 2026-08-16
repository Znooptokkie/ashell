import QtQuick
import QtQuick.Shapes

Item
{
    property real sX: 0
    property real sY: 0
    property real endX: 0
    property real endY: 0

    property color lineColor: "white"
    property real lineWidth: 2

    Shape
    {
        anchors.fill: parent

        ShapePath
        {
            fillColor: "transparent"
            strokeWidth: lineWidth
            strokeColor: lineColor
            strokeStyle: ShapePath.DashLine

            startX: sX
            startY: sY

            PathLine { x: endX; y: endY }
        }
    }
}