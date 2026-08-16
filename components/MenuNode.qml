import QtQuick
import QtQuick.Shapes

Item
{
    property string menuName: "menu item"
    property var corners: []
 
    property real xValue: 0
    property real yValue: 0
    
    property color lineColor: "white"
    property real lineWidth: 2

    width: 150
    height: 150

    x: xValue
    y: yValue

    Shape
    {
        anchors.fill: parent

        ShapePath
        {
            fillColor: "transparent"
            strokeWidth: lineWidth
            strokeColor: lineColor
            strokeStyle: ShapePath.DashLine

            startX: 0
            startY: 0

            PathLine { x: xValue + 100; y: yValue + 100 }
        }   
    }

    Text
    {
        
        anchors.centerIn: parent
        
        text: menuName
        color: "red"
    }
}