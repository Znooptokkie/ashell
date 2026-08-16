import QtQuick

Rectangle
{
    property string menuName: "menu item"

    property real xValue: 0
    property real yValue: 0

    width: 100
    height: 100

    x: xValue
    y: yValue

    color: "transparent"
    border.color: "white"
    border.width: 2

    Text
    {
        anchors.centerIn: parent

        text: menuName
        color: "green"
    }
}