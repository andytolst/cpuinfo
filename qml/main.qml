import QtQuick 2.0

Item {
    id: mainWindow

    width: 800
    height: 600

    // TODO: theming
    readonly property int spacing: 5
    readonly property color backgroundColor: "grey"
    readonly property color borderColor: "#5D4C46"
    readonly property color buttonColor: "#F1A94E"
    readonly property color panelColor: "#F2EDD8"
    readonly property color listNormalColor: "#7B8D8E"
    readonly property color listHighlightColor: "#44B3C2"

    Rectangle {
        id: background
        anchors.fill: parent
        color: backgroundColor
    }

    ListView {
        id: list
        anchors.top: parent.top
        anchors.bottom: refreshButon.top
        anchors.left: parent.left
        anchors.right: fullInfoPanel.left
        anchors.margins: mainWindow.spacing

        spacing: mainWindow.spacing
        model: CpuModel

        // Delegate displays basic CPU info: name, freqency, cache size
        delegate: Rectangle {
            height: 80
            width: list.width
            color: list.currentIndex == index ? mainWindow.listHighlightColor : mainWindow.listNormalColor
            border.color: mainWindow.borderColor

            Text {
                anchors.fill: parent
                anchors.margins: mainWindow.spacing

                elide: Text.ElideRight
                font.bold: true
                font.pixelSize: 20

                text: processor + ". " + model_name
            }

            Text {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.margins: mainWindow.spacing

                text: cpu_MHz + " MHz"
            }

            Text {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.margins: mainWindow.spacing

                text: cache_size
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    list.currentIndex = index;
                }
            }
        }
    }

    // Full information about CPU
    Rectangle {
        id: fullInfoPanel
        color: mainWindow.panelColor
        border.color: mainWindow.borderColor

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: mainWindow.spacing
        width: mainWindow.width  * .60

        Text {
            id: fullInfoText
            anchors.fill: parent
            anchors.margins: mainWindow.spacing

            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            elide: Text.ElideRight
            font.pixelSize: 14

            text: CpuModel.prettyFormat(list.currentIndex)
        }
    }

    // Refresh button
    Rectangle {
        id: refreshButon
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: list.width
        anchors.margins: mainWindow.spacing
        height: 80

        color: mainWindow.buttonColor
        border.color: mainWindow.borderColor

        Text {
            anchors.centerIn: parent
            font.bold: true
            font.pixelSize: 20

            // TODO: translate
            text: "Refresh"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                CpuModel.populateModel();

                // little hack to trigger update the full info text
                var index = list.currentIndex;
                list.currentIndex = -1;
                list.currentIndex = index;
            }
        }
    }
}
