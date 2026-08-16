import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

// import "../" as Config
import "../../config" as Config

PanelWindow 
{
    anchors 
	{
        top: true
        right: true
    }

	aboveWindows: false
    focusable: false
    exclusionMode: ExclusionMode.Ignore

    implicitWidth: 250
	implicitHeight: 115

	margins 
	{
		top: 36
		right: 10
	}

    color: "transparent"

    property real downloadSpeed: 0
    property real uploadSpeed: 0
    property real ping: 0
    property string wifiName: "Not connected"
    property string localIp: "Not available"
    property bool wifiSecured: false

    Process 
	{
        id: statsProcess

        command: ["bash", "-c",
            "iface=$(ip route | awk '/default/ {print $5; exit}'); " +
            "prev_rx=$(cat /sys/class/net/$iface/statistics/rx_bytes 2>/dev/null || echo 0); " +
            "prev_tx=$(cat /sys/class/net/$iface/statistics/tx_bytes 2>/dev/null || echo 0); " +

            "while true; do " +
            "  sleep 1; " +

            "  rx=$(cat /sys/class/net/$iface/statistics/rx_bytes 2>/dev/null || echo 0); " +
            "  tx=$(cat /sys/class/net/$iface/statistics/tx_bytes 2>/dev/null || echo 0); " +

            "  down=$((rx-prev_rx)); " +
            "  up=$((tx-prev_tx)); " +

            "  latency=$(ping -c 1 -W 1 1.1.1.1 2>/dev/null | " +
            "    awk -F'time=' '/time=/{print $2}' | awk '{print $1}'); " +
            "  [ -z \"$latency\" ] && latency=0; " +

            "  wifi=$(iwctl station \"$iface\" show 2>/dev/null); " +
            "  ssid=$(echo \"$wifi\" | sed -n 's/.*Connected network[[:space:]]*//p' | head -1 | xargs); " +
            "  security=$(echo \"$wifi\" | sed -n 's/.*Security[[:space:]]*//p' | head -1 | xargs); " +

            "  [ -z \"$ssid\" ] && ssid=\"Not connected\"; " +
            "  [ -n \"$security\" ] && secured=1 || secured=0; " +

            "  ip=$(ip -4 addr show \"$iface\" 2>/dev/null | " +
            "    awk '/inet / {print $2}' | cut -d/ -f1 | head -1); " +
            "  [ -z \"$ip\" ] && ip=\"Not available\"; " +

            "  down_mbps=$(awk -v d=\"$down\" 'BEGIN {printf \"%.1f\", d*8/1000000}'); " +
            "  up_mbps=$(awk -v u=\"$up\" 'BEGIN {printf \"%.1f\", u*8/1000000}'); " +

            "  printf '%s\\t%s\\t%s\\t%.1f\\t%s\\t%s\\t%s\\n' " +
            "    \"$iface\" \"$down_mbps\" \"$up_mbps\" \"$latency\" \"$ssid\" \"$secured\" \"$ip\"; " +

            "  prev_rx=$rx; " +
            "  prev_tx=$tx; " +
            "done"
        ]

        running: true

        stdout: SplitParser 
		{
            onRead: data => 
			{
                let parts = data.trim().split("\t")

                if (parts.length === 7) 
				{
                    downloadSpeed = Number(parts[1])
                    uploadSpeed = Number(parts[2])
                    ping = Number(parts[3])
                    wifiName = parts[4]
                    wifiSecured = parts[5] === "1"
                    localIp = parts[6]
                }
            }
        }
    }

    // Background
    Rectangle 
	{
        anchors.fill: parent

        color: Config.Theme.background
		opacity: Config.Theme.backgroundOpacity
        radius: Config.Theme.radius
    }

    // Content
    Column 
	{
        anchors 
		{
            fill: parent
            margins: Config.Theme.padding
        }

        spacing: 7

        // Wi-Fi
		Row 
		{
			spacing: 8

			Text 
			{
			    text: "󰖩"
			    font.family: Config.Theme.iconFont
			    font.pixelSize: Config.Theme.textSize
			    color: Config.Theme.primary
				opacity: Config.Theme.iconOpacity
			}
        	
			Text 
			{
        	    text: wifiName
        	    color: Config.Theme.text
        	    font.pixelSize: Config.Theme.textSize
        	    font.bold: true
				font.family: Config.Theme.font
        	    elide: Text.ElideRight
        	    width: 280
        	}
		}

		// IP address
		Row			
		{
			spacing: 8

			Text 
			{
			    text: "󰖟"
			    font.family: Config.Theme.iconFont
			    font.pixelSize: Config.Theme.textSize
			    color: Config.Theme.primary
				opacity: Config.Theme.iconOpacity
			}

        	Text 
			{
        	    text: localIp
        	    color: Config.Theme.text
        	    font.pixelSize: Config.Theme.smallTextSize
				font.family: Config.Theme.font
        	}
		}

		// Ping + security
		Row 
		{
		    spacing: 8
			
			Rectangle 
			{
				implicitWidth: 8
				implicitHeight: 8
				radius: 4

				anchors.verticalCenter: parent.verticalCenter
				anchors.verticalCenterOffset: -1

				color: Config.Theme.success

				SequentialAnimation on opacity 
				{
				    loops: Animation.Infinite

				    NumberAnimation 
					{
				        to: 0.3
				        duration: 800
				    }

				    NumberAnimation 
					{
				        to: 1.0
				        duration: 800
				    }
				}
			}

        	Text 
			{
        	    text: ping.toFixed(0) + " ms"
        	    color: Config.Theme.text
        	    font.pixelSize: Config.Theme.smallTextSize
				font.family: Config.Theme.font
        	}

		    Text 
			{
		        text: "·"
		        color: Config.Theme.textMuted
		        font.pixelSize: Config.Theme.smallTextSize
		        font.family: Config.Theme.font
		    }

		    Text  
			{
		        text: wifiSecured ? "Secured" : "Unsecured"
		        color: wifiSecured ? Config.Theme.success : Config.Theme.error
		        font.pixelSize: Config.Theme.smallTextSize
		        font.family: Config.Theme.font
		    }
		}
    }
}