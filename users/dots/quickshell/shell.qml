import QtQuick  
import QtQuick.Controls  
import QtQuick.Layouts  
import Quickshell  
  
ShellRoot {  
    PanelWindow {  
        id: launcher  
        width: 600  
        height: 400  
        visible: true  
          
        color: "#2b2b2b"  
          
        ColumnLayout {  
            anchors.fill: parent  
            anchors.margins: 20  
              
            // Search field  
            TextField {  
                id: searchField  
                Layout.fillWidth: true  
                placeholderText: "Search applications..."  
                  
                onTextChanged: {  
                    appModel.values = DesktopEntries.applications.values.filter(  
                        app => app.name.toLowerCase().includes(text.toLowerCase()) ||  
                               app.genericName.toLowerCase().includes(text.toLowerCase())  
                    )  
                }  
            }  
              
            // Application grid  
            ScrollView {  
                Layout.fillWidth: true  
                Layout.fillHeight: true  
                  
                GridView {  
                    id: appGrid  
                    cellWidth: 120  
                    cellHeight: 120  
                      
                    model: ScriptModel {  
                        id: appModel  
                        values: DesktopEntries.applications.values  
                    }  
                      
                    delegate: Rectangle {  
                        width: appGrid.cellWidth - 10  
                        height: appGrid.cellHeight - 10  
                        color: mouseArea.containsMouse ? "#404040" : "transparent"  
                        radius: 8  
                          
                        Column {  
                            anchors.centerIn: parent  
                            spacing: 8  
                              
                            // App icon (placeholder)  
                            Rectangle {  
                                width: 48  
                                height: 48  
                                color: "#555555"  
                                radius: 8  
                                anchors.horizontalCenter: parent.horizontalCenter  
                                  
                                Text {  
                                    anchors.centerIn: parent  
                                    text: modelData.name.charAt(0).toUpperCase()  
                                    color: "white"  
                                    font.pixelSize: 24  
                                    font.bold: true  
                                }  
                            }  
                              
                            // App name  
                            Text {  
                                text: modelData.name  
                                color: "white"  
                                font.pixelSize: 12  
                                width: parent.parent.width - 10  
                                horizontalAlignment: Text.AlignHCenter  
                                wrapMode: Text.WordWrap  
                                maximumLineCount: 2  
                                elide: Text.ElideRight  
                            }  
                        }  
                          
                        MouseArea {  
                            id: mouseArea  
                            anchors.fill: parent  
                            hoverEnabled: true  
                              
                            onClicked: {  
                                modelData.execute()  
                                launcher.visible = false  
                            }  
                        }  
                    }  
                }  
            }  
        }  
    }  
}
