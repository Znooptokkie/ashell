import QtQuick
import Quickshell
import "../../components"

PanelWindow
{
    aboveWindows: false
    color: "transparent"
    
    anchors
    {
        top: true
        right: true
        bottom: true
        left: true
    }
    
    margins
    {
        top: 100
        right: 300
        bottom: 100
        left: 300
    }

    // FIX: Is tijdelijke placeholder om border aan te geven
    Rectangle
    {
        width: parent.width
        height: parent.height
        color: "transparent"
        border.color: "white"
        border.width: 1
    }

    Item
    {
        id: menuArea

        width: parent.width
        height: parent.height

        MenuNode
        {
            id: node0
            menuName: "0"
            // Bepaal startpositie - 250 & 150 zijn willekeurige waardes
            startX: (menuArea.width / 2) - (width / 2) + (0 * 250)
            startY: (menuArea.height / 2) - (height / 2) + (0 * 150)
            
        }

        MenuNode
        {
            id: node1
            menuName: "1"
            // Bepaal startpositie - 250 & 150 zijn willekeurige waardes
            startX: (menuArea.width / 2) - (width / 2) + (1 * 250)
            startY: (menuArea.height / 2) - (height / 2) + (1 * 150)
        }

        MenuNodeConnection
        {
            width: menuArea.width
            height: menuArea.height
            // Gebruik startpositie van nodes + de helft van de node zelf
            sX: node0.startX + (node0.width / 2)
            sY: node0.startY + (node0.height / 2)
            endX: node1.startX + (node1.width / 2)
            endY: node1.startY + (node1.height / 2)
        }
    }
}