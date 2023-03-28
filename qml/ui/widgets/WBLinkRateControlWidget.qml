import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.0

import Qt.labs.settings 1.0

import OpenHD 1.0

import "../elements"

BaseWidget {

    id: wblinkratewidget
    width: 96
    height: 25

    visible: settings.wb_link_rate_control_widget_show

    widgetIdentifier: "wb_link_rate_control_widget"

    defaultAlignment: 0
    defaultXOffset: 400
    defaultYOffset: 2
    defaultHCenter: false
    defaultVCenter: false

    hasWidgetDetail: true
    hasWidgetAction: true

    widgetDetailComponent: ScrollView {

        contentHeight: wbLinkRateSettingsColumn.height
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        clip: true
        Column {
            id: wbLinkRateSettingsColumn
            width: parent.width
            height:parent.height
            Item {
                width: parent.width
                height: 42
                Text {
                    text: qsTr("WB Link rate")
                    color: "white"
                    height: parent.height - 10
                    width: parent.width
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: detailPanelFontPixels
                    verticalAlignment: Text.AlignVCenter
                }
                Rectangle {
                    y: 34
                    width: parent.width
                    height: 3
                    color: "white"
                    radius: 5
                }
            }
            Item {
                width: parent.width
                height: 32
                Text {
                    text: qsTr("Size")
                    color: "white"
                    height: parent.height
                    font.bold: true
                    font.pixelSize: detailPanelFontPixels
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                }
                Slider {
                    id: mission_size_Slider
                    orientation: Qt.Horizontal
                    from: .5
                    value: bw_current_scale
                    to: 3
                    stepSize: .1
                    height: parent.height
                    anchors.rightMargin: 0
                    anchors.right: parent.right
                    width: parent.width - 96

                    onValueChanged: {
                        bw_set_current_scale(mission_size_Slider.value)
                    }
                }
            }
        }
    }

    //---------------------------ACTION WIDGET COMPONENT BELOW-----------------------------
    widgetActionComponent: ScrollView {

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        clip: true

        ColumnLayout {
            width: 200
            spacing: 10

            Item {
                height: 32
                Text {
                    text: "Control link & video bitrate"
                    color: "white"
                    font.bold: true
                    font.pixelSize: detailPanelFontPixels
                    anchors.left: parent.left
                }
            }
            Item{
                width: parent.width
                height: parent.height - 32
                //color: "green"
                GridLayout{
                    width: parent.width
                    height: parent.height
                    rows: 2
                    columns: 2
                    Button{
                        text: "MCS0"
                        onClicked: {
                             _synchronizedSettings.change_param_air_only_mcs(0,true)
                            console.log("XX"+_synchronizedSettings.dirty_curr_mcs_index)
                        }
                        highlighted: _synchronizedSettings.dirty_curr_mcs_index==0
                    }
                    Button{
                        text: "MCS1"
                        onClicked: {
                             _synchronizedSettings.change_param_air_only_mcs(1,true)
                        }
                        highlighted: _synchronizedSettings.dirty_curr_mcs_index==1
                    }
                    Button{
                        text: "MCS2"
                        onClicked: {
                             _synchronizedSettings.change_param_air_only_mcs(2,true)
                        }
                        highlighted: _synchronizedSettings.dirty_curr_mcs_index==2
                    }
                    Button{
                        text: "MCS3"
                        onClicked: {
                             _synchronizedSettings.change_param_air_only_mcs(3,true)
                        }
                        highlighted: _synchronizedSettings.dirty_curr_mcs_index==3
                    }
                    /*Button{
                        text: "MCS4"
                        onClicked: {
                             _synchronizedSettings.change_param_air_only_mcs(4,true)
                        }
                    }*/
                }
            }
        }
    }

    Item {
        id: widgetInner
        anchors.fill: parent
        scale: bw_current_scale

        Item {
            anchors.fill: parent
            anchors.centerIn: parent

            Text {
                y: 0
                width: parent.width
                height: 14
                color: settings.color_text
                text: qsTr("Exp(WBLink)")
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 14
                font.family: settings.font_text
                style: Text.Outline
                styleColor: settings.color_glow
            }
        }
    }
}