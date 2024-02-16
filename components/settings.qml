import QtQuick 2.15
import QtGraphicalEffects 1.12

FocusScope {
    id: settings

    Rectangle {			
		width: parent.width
		height: parent.height
		anchors.fill: parent
		color: colorScheme[theme].background
		}
		
	Text {
		anchors {
            top: parent.top
            topMargin: vpx(50)
            bottom: parent.bottom
            left: parent.left
			leftMargin: vpx(200)
        }
		text: "Theme Settings"
        font.family: globalFonts.sans
		font.pixelSize: vpx(50)
		font.bold: true
		color: colorScheme[theme].text
	}

    ListModel {
        id: settingsModel
        
		Component.onCompleted: {
            [
            [ "Games View",  "gamesview",  "",  "Wheel,List" ],
            [ "Theme Color",  "theme",  "",  "Dark,Light,OzoneDark,SteamOS,Black" ],
			[ "Logo Variation",  "logo",  "",  "Dark - Color,Dark - Black,Light - Color,Light - White" ],
			[ "Accept Button",  "buttons",  "",  "A,B,Cross (X),Circle (O)" ],
			[ "Video Sounds",  "videosound",  "",  "Enabled,Disabled" ],
			[ "Show All Games", "allGamesCollection", "", "Yes,No" ],
			[ "Show Favorites", "favoritesCollection", "", "Yes,No" ],
			[ "Show Last Played", "lastPlayedCollection", "", "Yes,No" ]
			
			
            ].forEach(function(element) {
                append({
                            settingName: element[0],
                            settingKey: element[1],
                            settingSubtitle: element[2],
                            setting: element[3]
                        });
            });
        }
    }

    property real itemheight: vpx(60)

    ListView {
        id: settingsList
        model: settingsModel
        delegate: settingsDelegate
        anchors {
            top: parent.top
            topMargin: vpx(150)
            bottom: parent.bottom
            left: parent.left
			leftMargin: vpx(200)
            right: parent.right
			rightMargin: vpx(200)
        }
        width: vpx(500)
        spacing: vpx(0)
        orientation: ListView.Vertical
		
		currentIndex: currentSettingsIndex
        onCurrentIndexChanged: currentSettingsIndex = currentIndex

        preferredHighlightBegin: settingsList.height / 2 - itemheight
        preferredHighlightEnd: settingsList.height / 2
        highlightRangeMode: ListView.ApplyRange
        highlightMoveDuration: 100
        clip: false
		focus: true

        Component {
            id: settingsDelegate
            Item {
                id: settingRow
                property bool selected: ListView.isCurrentItem
                property var settingList: setting.split(',')
                property int savedIndex: api.memory.get(settingKey + 'Index') || 0

                function saveSetting() {
                    api.memory.set(settingKey + 'Index', savedIndex);
                    api.memory.set(settingKey, settingList[savedIndex]);
                }

                function nextSetting() {
                    if (savedIndex != settingList.length -1)
                        savedIndex++;
                    else
                        savedIndex = 0;
                }

                function prevSetting() {
                    if (savedIndex > 0)
                        savedIndex--;
                    else
                        savedIndex = settingList.length -1;
                }

                width: ListView.view.width
                height: itemheight

				MouseArea {
					anchors.fill: parent
					onClicked: {
						if (selected) {
							nextSetting();
							saveSetting();}
						else
							settingsList.focus = true; 
							settingsList.currentIndex = index;
					}
				}

                Text {
                    id: settingNameText
                    text: settingSubtitle != "" ? settingName + " " + settingSubtitle + ": " : settingName + ": "
                    color: colorScheme[theme].text
                    font {
                        family: global.fonts.condensed
                        pixelSize: vpx(30)
                    }
                    verticalAlignment: Text.AlignVCenter
                    opacity: selected ? 1 : 0.2

                    width: contentWidth
                    height: parent.height
                    anchors {
                        left: parent.left
                        leftMargin: vpx(40)
                    }
                }

                Text { 
                    id: settingtext; 
                    text: settingList[savedIndex]; 
                    color: colorScheme[theme].accent
                    font {
                        family: global.fonts.condensed
                        pixelSize: vpx(30)
                    }
                    verticalAlignment: Text.AlignVCenter
                    opacity: selected ? 1 : 0.2

                    height: parent.height
                    anchors {
                        right: parent.right
                        rightMargin: vpx(40)
                    }
                }

                Rectangle {
                    anchors {
                        left: parent.left
                        leftMargin: vpx(25)
                        right: parent.right
                        rightMargin: vpx(25)
                        bottom: parent.bottom
                    }
                    color: colorScheme[theme].text
                    opacity: selected ? 0.1 : 0
                    height: vpx(1)
                }

                Keys.onRightPressed: {
                    nextSetting();
                    saveSetting();
                }

                Keys.onLeftPressed: {
                    prevSetting();
                    saveSetting();
                }

                Keys.onPressed: {
                    if (api.keys.isAccept(event) && !event.isAutoRepeat) {
                        event.accepted = true;
                        nextSetting();
                        saveSetting();
                    }
					if (api.keys.isCancel(event) && !event.isAutoRepeat) {
                        event.accepted = true;
						if (api.memory.has('prevView')) {     
							root.state = gamesview;
							api.memory.unset('prevView') }
						else									
							root.state = 'collections'
                    }
                    if (event.key == 1048586 && !event.isAutoRepeat) {
                        event.accepted = true;
						if (api.memory.has('prevView')) {     
							root.state = gamesview;
							api.memory.unset('prevView') }
						else									
							root.state = 'collections'
                    }
                }
            }
        }

        Keys.onUpPressed: {
            decrementCurrentIndex();
        }

        Keys.onDownPressed: {
            incrementCurrentIndex();
        }
    }
}
