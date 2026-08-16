import QtQuick
import QtQuick.Shapes

Item
{
    property string menuName: "menu item"

    property var cornerPoints: [
        { x: 37.5, y: 0 },
        { x: 112.5, y: 0 },
        { x: 150, y: 75 },
        { x: 112.5, y: 150 },
        { x: 37.5, y: 150 },
        { x: 0, y: 75 }
    ]
 
    property real startX: 0
    property real startY: 0
    
    property color lineColor: "white"
    property real lineWidth: 1

    width: 150
    height: 150

    x: startX
    y: startY

    Shape
    {
        anchors.fill: parent

        ShapePath
        {
            fillColor: "transparent"
            strokeWidth: lineWidth
            strokeColor: lineColor
            strokeStyle: ShapePath.Line

            startX: cornerPoints[0].x
            startY: cornerPoints[0].y

            PathLine { x: cornerPoints[1].x; y: cornerPoints[1].y }
            PathLine { x: cornerPoints[2].x; y: cornerPoints[2].y }
            PathLine { x: cornerPoints[3].x; y: cornerPoints[3].y }
            PathLine { x: cornerPoints[4].x; y: cornerPoints[4].y }
            PathLine { x: cornerPoints[5].x; y: cornerPoints[5].y }
            PathLine { x: cornerPoints[0].x; y: cornerPoints[0].y }
        }  
    }

    Text
    {
        
        anchors.centerIn: parent
        
        text: menuName
        color: "red"
    }
}