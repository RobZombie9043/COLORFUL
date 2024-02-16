import QtQuick 2.3
import QtMultimedia 5.15
import QtGraphicalEffects 1.15
import "qrc:/qmlutils" as PegasusUtils
import SortFilterProxyModel 0.2

FocusScope {
    id: collections
	
	property var currentCollection: api.collections.get(collectionAxis.currentIndex)
	property var titleContentHeight: collectionTitle.contentHeight
	property var vendorYearContentHeight: vendorYear.contentHeight
	property var summaryContentHeight: collectionSummary.contentHeight
    property string state: root.state
	property bool playing: false
	
	Rectangle {											
		width: parent.width
		height: parent.height
		anchors.fill: parent
		color: colorScheme[theme].background
	}

	ListView {												
		id: collectionAxis
		
		model: api.collections
		delegate: collectionAxisDelegate
		
		width: parent.width / 3
		height: parent.height
		anchors.right: parent.right
	
		focus:true
		keyNavigationWraps: true	
		
		Keys.onPressed:{
			if (api.keys.isAccept(event))
			{
				event.accepted = true;
				gameslist.currentGameIndex = 0;
				gameswheel.currentGameIndex = 0;
				root.state = gamesview                       
			}
			if (api.keys.isDetails(event))
			{
				event.accepted = true;
				root.state = 'settings'
			}
			if (event.key == 1048586)
			{
				event.accepted = true;
				root.state = 'settings'
			}
			if (api.keys.isCancel(event))
			{
				if (transitions.state === 'collectionDetails') {
				event.accepted = true;
				transitions.state = 'collectionSelection';
				}
			}
		}
		
		preferredHighlightBegin : height * 0.5
		preferredHighlightEnd: height * 0.5
		
		spacing: vpx(144);
		
		snapMode: ListView.SnapOneItem
		highlightRangeMode: ListView.StrictlyEnforceRange
		highlightMoveDuration: 200
		
		currentIndex: currentCollectionIndex							
		onCurrentIndexChanged: currentCollectionIndex = currentIndex

		Component {
			id: collectionAxisDelegate

			Item {
				Text {
					id: collectionText
					anchors.centerIn: parent
					horizontalAlignment : Text.AlignHCenter
					verticalAlignment : Text.AlignVCenter
					width: 320
					text: modelData.name
					color: colorScheme[theme].text 
					font.family: globalFonts.sans
					font.pixelSize: index === collectionAxis.currentIndex ? vpx (30) : vpx (15)
					font.bold: true
					wrapMode: Text.Wrap
					maximumLineCount: 3
					elide: Text.ElideRight
					opacity: index === collectionAxis.currentIndex ? 1 : 0.3

					visible: false
				}
			
				Image {
					id: collectionLogo

					width: index === collectionAxis.currentIndex ? vpx (320) : vpx (160)
					height: index === collectionAxis.currentIndex ? vpx (120) : vpx (50)
					anchors.verticalCenter: parent.verticalCenter
					anchors.horizontalCenter: parent.horizontalCenter
					fillMode: Image.PreserveAspectFit

					source: "../assets/images/logos/" + logo + "/" + collectiondata.getAlias(modelData.shortName) + ".png" 
					
					asynchronous: true
					opacity: index === collectionAxis.currentIndex ? 1 : 0.3
					
					onStatusChanged: {
						if (collectionLogo.status === Image.Error) {
							collectionText.visible = true;
						} else {
							collectionText.visible = false;
						}
					}
					
					MouseArea {											
						anchors.fill: parent
						onClicked: {
							collectionAxis.currentIndex = index; 		
						}
					}
				}
			}
		}
	}
	
	Item {														
		id: collectionNameContainer
			width: parent.width * 0.5
			anchors.left: parent.left
			anchors.verticalCenter: parent.verticalCenter

			
		Text {
			id: collectionName
			
			text: currentCollection.name
			color: colorScheme[theme].text 
			opacity: 0.5
			anchors.verticalCenter: parent.verticalCenter
			anchors.right: parent.right
			anchors.rightMargin: vpx(30)
			font.family: globalFonts.sans
			font.pixelSize: vpx(30)
			font.bold: true
		}
	}
	
	Item {															
		id: collectionYearContainer
			width: parent.width * 1/6
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter

			
		Text {
			id: collectionYear
			
			text: collectiondata.getYear(currentCollection.shortName);	
			color: colorScheme[theme].text 
			opacity: 0.5
			anchors.verticalCenter: parent.verticalCenter
			anchors.left: parent.left
			anchors.leftMargin: vpx(30)
			font.family: globalFonts.sans
			font.pixelSize: vpx(30)
			font.bold: true
		}
	}
	
	Rectangle {												
		id: dividerRight
		width: vpx (2)
		height: vpx (40)
		anchors.right: parent.right
		anchors.rightMargin: parent.width / 6
		anchors.verticalCenter: parent.verticalCenter
		color: colorScheme[theme].text 
		opacity: 0.3
	}
	
	Rectangle {											
		id: dividerLeft
		width: vpx (2)
		height: vpx (40)
		anchors.right: parent.right
		anchors.rightMargin: parent.width / 2
		anchors.verticalCenter: parent.verticalCenter
		color: colorScheme[theme].text 
		opacity: 0.3
	}

	Item {
		id: transitions
	
		transitions: [
			Transition {
				to: "collectionDetails"
				NumberAnimation { target: collectionNameContainer; property: "opacity"; to: 0 ; duration: 250 }
				NumberAnimation { target: collectionYearContainer; property: "opacity"; to: 0 ; duration: 250 }
				NumberAnimation { target: dividerLeft; property: "opacity"; to: 0 ; duration: 250 }
				NumberAnimation { target: dividerRight; property: "opacity"; to: 0 ; duration: 250 }
				NumberAnimation { target: collectionAxis; property: "opacity"; to: 0 ; duration: 250 }
				SequentialAnimation {
					ParallelAnimation { 
						NumberAnimation { target: videocontainer; property: "width"; to: vpx(730); duration: 500 }
						NumberAnimation { target: videocontainer; property: "anchors.leftMargin"; to: vpx(520); duration: 500 }
					}
					ParallelAnimation {
						NumberAnimation { target: scrollbuttonsContainer; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: vendoryearContainer; property: "opacity"; to: 1; duration: 500 }
						NumberAnimation { target: vendoryearContainer; property: "anchors.leftMargin"; to: vpx(40); duration: 500 }
					}
					ParallelAnimation { 
						NumberAnimation { target: collectiontitleContainer; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: collectiontitleRectangle; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: collectiontitleContainer; property: "anchors.leftMargin"; to: vpx(40); duration: 500 }
						NumberAnimation { target: collectiontitleRectangle; property: "width"; to: 0; duration: 500 }
					}
					ParallelAnimation { 
						NumberAnimation { target: collectionsummaryContainer; property: "opacity"; to: 1; duration: 500 }
						NumberAnimation { target: collectionsummaryContainer; property: "anchors.leftMargin"; to: vpx(40); duration: 500 }
					}
					ParallelAnimation {
						NumberAnimation { target: gameinfoContainer; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: gameinfoRect; property: "width"; to: vpx(560); duration: 500 }
						SequentialAnimation {
							PauseAnimation { duration: 250 }
							ParallelAnimation {
								NumberAnimation { target: gameinfoRectColour; property: "opacity"; to: 1; duration: 0 }
								NumberAnimation { target: gameinfoRectColour; property: "width"; to: vpx(160); duration: 500 }
								NumberAnimation { target: gameinfoAccent; property: "opacity"; to: 1; duration: 0 }
								NumberAnimation { target: gameinfoAccent; property: "width"; to: 10; duration: 500 }
								NumberAnimation { target: gameinfoDivider; property: "opacity"; to: 0.3; duration: 500 }
								NumberAnimation { target: gameinfoDivider; property: "anchors.topMargin"; to: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10) + vpx(10); duration: 500 }
								SequentialAnimation {
									PauseAnimation { duration: 250 }
									ParallelAnimation {
										NumberAnimation { target: gamescountContainer; property: "opacity"; to: 1; duration: 500 }
										NumberAnimation { target: gamescountContainer; property: "anchors.topMargin"; to: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10); duration: 500 }										
										NumberAnimation { target: favouritescountContainer; property: "opacity"; to: 1; duration: 500 }
										NumberAnimation { target: favouritescountContainer; property: "anchors.topMargin"; to: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10); duration: 500 }		
										NumberAnimation { target: pressxContainer; property: "opacity"; to: 1; duration: 500 }
										NumberAnimation { target: pressxContainer; property: "anchors.topMargin"; to: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10); duration: 500 }		
									}
								}
							}
							
						}
					}
				}
			},
			Transition {
				to: "collectionSelection"
				NumberAnimation { target: collectionNameContainer; property: "opacity"; to: 1 ; duration: 0 }
				NumberAnimation { target: collectionYearContainer; property: "opacity"; to: 1 ; duration: 0 }
				NumberAnimation { target: dividerLeft; property: "opacity"; to: 0.3 ; duration: 0 }
				NumberAnimation { target: dividerRight; property: "opacity"; to: 0.3 ; duration: 0 }
				NumberAnimation { target: collectionAxis; property: "opacity"; to: 1 ; duration: 0 }
				NumberAnimation { target: videocontainer; property: "width"; to: 0; duration: 0 }
				NumberAnimation { target: videocontainer; property: "anchors.leftMargin"; to: vpx(30); duration: 0 }
				NumberAnimation { target: scrollbuttonsContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: collectiontitleContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: collectiontitleRectangle; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: collectiontitleContainer; property: "anchors.leftMargin"; to: vpx(0); duration: 0 }
				NumberAnimation { target: collectiontitleRectangle; property: "width"; to: vpx(482); duration: 0 }
				NumberAnimation { target: gameinfoContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: vendoryearContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: vendoryearContainer; property: "anchors.leftMargin"; to: vpx(0); duration: 0 }
				NumberAnimation { target: collectionsummaryContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: collectionsummaryContainer; property: "anchors.leftMargin"; to: vpx(0); duration: 0 }
				NumberAnimation { target: gameinfoRect; property: "width"; to: vpx(400); duration: 0 }
				NumberAnimation { target: gameinfoRectColour; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoRectColour; property: "width"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoAccent; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoAccent; property: "width"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoDivider; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoDivider; property: "anchors.topMargin"; to: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10) + vpx(10) + vpx(10); duration: 0 }
				NumberAnimation { target: gamescountContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gamescountContainer; property: "anchors.topMargin"; to: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10) + vpx(20); duration: 0 }		
				NumberAnimation { target: favouritescountContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: favouritescountContainer; property: "anchors.topMargin"; to: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10) + vpx(20); duration: 0 }		
				NumberAnimation { target: pressxContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: pressxContainer; property: "anchors.topMargin"; to: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10) + vpx(20); duration: 0 }		
			}
		]
	}

	Item {
		id: videocontainer
					
		width: parent.width * 0
		height: parent.height
		anchors.left: parent.left
		anchors.leftMargin: vpx(40)		
		anchors.top: parent.top
		anchors.topMargin: vpx(30)
		anchors.bottom: parent.bottom
		anchors.bottomMargin: vpx(30)

		Rectangle {
			id: collectiondevicebg
			
			anchors.fill: parent
			color: collectiondata.getColor(currentCollection.shortName);
		}
		
		Image {
			id: collectiondeviceimage
			
			anchors.fill: parent
			fillMode: Image.PreserveAspectFit
			source: "../assets/images/devices/" + collectiondata.getAlias(currentCollection.shortName) + ".png"
		}
		
		Loader {
			id: videoPreviewLoader
			asynchronous: true
			anchors { fill: parent }
		}
	}		

	onCurrentCollectionChanged: {
		videoPreviewLoader.sourceComponent = undefined;
		videoDelay.restart();
		scrollArea.restartScroll();
		scrollDelay.restart();
		transitions.state = "collectionSelection"
	}

	onPlayingChanged: {
		videoPreviewLoader.sourceComponent = undefined;
		videoDelay.restart();
		scrollArea.restartScroll();
		scrollDelay.restart();
		transitions.state = "collectionSelection"
	}

	onStateChanged: {
		videoPreviewLoader.sourceComponent = undefined;
		videoDelay.restart();
		scrollArea.restartScroll();
		scrollDelay.restart();
		transitions.state = "collectionSelection"
	}

	property string videoSource: "../assets/videos/devices/" + collectiondata.getAlias(currentCollection.shortName) + ".mp4"

	Timer {
		id: videoDelay

		interval: 1500
		onTriggered: {
			if (currentCollection && root.state === 'collections')
			{
				videoPreviewLoader.sourceComponent = videoPreviewWrapper;
				transitions.state = "collectionDetails";
			}
		}
	}
	
	Timer {
		id: scrollDelay

		interval: 3000
		onTriggered: {
			if (currentCollection && root.state === 'collections')
			{
				scrollArea.restartScroll();
			}
		}
	}

	Component {
		id: videoPreviewWrapper

		Video {
			id: videocomponent
				
			source: videoSource ?? ""
			fillMode: VideoOutput.PreserveAspectCrop
			loops: MediaPlayer.Infinite
			autoPlay: true
			visible: videoSource
			muted: videosound
		}
	}

	
	Item {
		id: collectiontitleContainer
		height: parent.height / 2
		anchors.left: parent.left
		anchors.leftMargin: vpx(0)
		anchors.top: parent.top
		opacity: 0

		
		Text {
			id: collectionTitle
			text: currentCollection.name
			color: colorScheme[theme].text 
			font.family: globalFonts.sans
			font.pixelSize: vpx(45)
			font.bold: true
			width: vpx(400)
			wrapMode: Text.Wrap
			verticalAlignment : Text.AlignBottom
			anchors.bottom: parent.bottom
			clip: true
		}
	}
	
	Rectangle {
		id: collectiontitleRectangle
		height: titleContentHeight
		width: vpx(400)
		anchors.right: parent.right
		anchors.rightMargin: vpx(840)
		anchors.bottom: parent.bottom
		anchors.bottomMargin: parent.height/2
		color: colorScheme[theme].background 
		opacity: 0
	}
	
	Item {
		id: vendoryearContainer
		width: vpx(400)
		anchors.left: parent.left
		anchors.leftMargin: vpx(0)
		anchors.top: parent.top
		anchors.topMargin: parent.height / 2 - titleContentHeight - vendorYearContentHeight - vpx(10)
		opacity: 0
		
		Text {
			id: vendorYear
			text: collectiondata.getVendorYear(currentCollection.shortName);
			color: collectiondata.getColor(currentCollection.shortName);
			font {
				capitalization: Font.AllUppercase;
				pixelSize: vpx(30);
				letterSpacing: 1.3;
				bold: true;
			}
			width: parent.width
			anchors.top: parent.top
			wrapMode: Text.Wrap
			verticalAlignment : Text.AlignBottom
		}
	}

	Item {
		id: collectionsummaryContainer
		width: vpx(400)
		height: vpx(112)
		anchors.top: parent.top
		anchors.topMargin: parent.height/2 + vpx(10)
		anchors.left: parent.left
		anchors.leftMargin: vpx(0)   
		opacity: 0

		PegasusUtils.AutoScroll {												
            id: scrollArea
			anchors.fill: parent
			Text {
				id: collectionSummary
				text: collectiondata.getSummary(currentCollection.shortName);
				color: colorScheme[theme].text 
				opacity: 0.7;
				font {
					pixelSize: vpx(15);
					bold: false;
					family: globalFonts.condensed
				}
				width: parent.width
				
				wrapMode: Text.WordWrap
				elide: Text.ElideRight
				horizontalAlignment: Text.AlignJustify
			}
		}
	}

	Item {										
		id: gameinfoContainer
		opacity: 0
		
		Rectangle {
			id: gameinfoRect
			height: vpx(120)
			width: vpx(400)
			anchors.left: parent.left
			anchors.leftMargin: vpx(40)
			anchors.top: parent.top
			anchors.topMargin: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10)
			color: colorScheme[theme].background 
		}
		
		DropShadow {
			id: gameinfoShadow
			anchors.fill: gameinfoRect
			horizontalOffset: -1
			verticalOffset: 5
			radius: 8
			samples: 17
			color: "#aa000000"
			source: gameinfoRect
		}
	}
	
	Rectangle {								
		id: gameinfoAccent
		height: vpx(120)
		width: vpx(0)
		anchors.left: parent.left
		anchors.leftMargin: vpx(40)
		anchors.top: parent.top
		anchors.topMargin: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10)
		color: collectiondata.getColor(currentCollection.shortName)
		opacity: 0
	}
	
								
	Rectangle {								
		id: gameinfoRectColour
		height: vpx(120)
		width: vpx(0)
		anchors.left: parent.left
		anchors.leftMargin: vpx(440)
		anchors.top: parent.top
		anchors.topMargin: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10)
		color: collectiondata.getColor(currentCollection.shortName)
		opacity: 0
	}
	
	
	Rectangle {								
		id: gameinfoDivider
		height: vpx(100)
		width: vpx(2)
		anchors.left: parent.left
		anchors.leftMargin: vpx(239)
		anchors.top: parent.top
		anchors.topMargin: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10) + vpx(10) + vpx(10)
		color: colorScheme[theme].text 
		opacity: 0
	}
	
	
	Item {
		id: gamescountContainer
		anchors.top: parent.top
		anchors.topMargin: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10) + vpx(20)
		anchors.left: parent.left
		anchors.leftMargin: vpx(50)
		
		opacity: 0
		
		Image {
			anchors.top: parent.top
			anchors.topMargin: -vpx (5)
			anchors.left: parent.left
			width: vpx(189)
			height: vpx(50)
			horizontalAlignment : Image.AlignHCenter
			verticalAlignment : Image.AlignVCenter
			fillMode: Image.PreserveAspectFit
			source: "../assets/images/icons/Colorful_IconGames.png"
		}
		
		Text{
			text: currentCollection.games.count
			color: collectiondata.getColor(currentCollection.shortName);
			font.family: globalFonts.sans
			font.pixelSize: vpx(30)
			font.bold: true
			anchors.top: parent.top
			anchors.topMargin: vpx (30)
			anchors.left: parent.left
			width: vpx(189)
			height: vpx(60)
			horizontalAlignment : Text.AlignHCenter
			verticalAlignment : Text.AlignVCenter
		}
		
		Text{
			text: "Games"
			color: colorScheme[theme].text 
			font.family: globalFonts.sans
			font.pixelSize: vpx(15)
			font.bold: true
			opacity: 0.3
			anchors.top: parent.top
			anchors.topMargin: vpx (70)
			anchors.left: parent.left
			width: vpx(189)
			height: vpx(50)
			horizontalAlignment : Text.AlignHCenter
			verticalAlignment : Text.AlignVCenter
		}
	}
	
	Item {
		property alias favouritesModel: favouritesProxyModel
		readonly property int maxFavourites: favouritesProxyModel.count
	
		SortFilterProxyModel {
            id: favouritesProxyModel
            sourceModel: currentCollection.games 
            filters: ValueFilter { roleName: "favorite"; value: true }
        }
	}
	
	Item {
		id: favouritescountContainer
		anchors.top: parent.top
		anchors.topMargin: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10) + vpx(20)
		anchors.left: parent.left
		anchors.leftMargin: vpx(241)
		
		opacity: 0
		
		Image {
			anchors.top: parent.top
			anchors.topMargin: vpx (10)
			anchors.left: parent.left
			width: vpx(189)
			height: vpx(26)
			horizontalAlignment : Image.AlignHCenter
			verticalAlignment : Image.AlignVCenter
			fillMode: Image.PreserveAspectFit
			source: "../assets/images/icons/Colorful_IconFav.png"
		}
		
		Text{
			text: favouritesProxyModel.count
			color: collectiondata.getColor(currentCollection.shortName);
			font.family: globalFonts.sans
			font.pixelSize: vpx(30)
			font.bold: true
			anchors.top: parent.top
			anchors.topMargin: vpx (30)
			anchors.left: parent.left
			width: vpx(189)
			height: vpx(60)
			horizontalAlignment : Text.AlignHCenter
			verticalAlignment : Text.AlignVCenter
		}
		
		Text{
			text: "Favourites"
			color: colorScheme[theme].text 
			font.family: globalFonts.sans
			font.pixelSize: vpx(15)
			font.bold: true
			opacity: 0.3
			anchors.top: parent.top
			anchors.topMargin: vpx (70)
			anchors.left: parent.left
			width: vpx(189)
			height: vpx(50)
			horizontalAlignment : Text.AlignHCenter
			verticalAlignment : Text.AlignVCenter
		}
	}
	
	Item {
		id: pressxContainer
		anchors.top: parent.top
		anchors.topMargin: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10) + vpx(20)
		anchors.left: parent.left
		anchors.leftMargin: vpx(440)
		
		opacity: 0
		
		Image {
			anchors.top: parent.top
			anchors.left: parent.left
			width: vpx(160)
			height: vpx(120)
			horizontalAlignment : Image.AlignHCenter
			verticalAlignment : Image.AlignVCenter
			fillMode: Image.PreserveAspectFit
			source: buttons 
		
			MouseArea {											
				anchors.fill: parent
				onClicked: {
					root.state = gamesview 		
				}
		
			}
		}
	}
	
	Rectangle {
		id: scrollbuttonsContainer
		anchors.right: parent.right
		anchors.rightMargin: vpx(30)		
		anchors.bottom: parent.bottom
		anchors.bottomMargin: vpx(30)
		color: colorScheme[theme].background 
		
		opacity: 0
		
		AnimatedImage {
			anchors.bottom: parent.bottom
			anchors.right: parent.right
			width: vpx(80)
			fillMode: Image.PreserveAspectFit
			source: "../assets/images/icons/Colorful_PlatformWheel_Arrows_Vertical_type2.gif"
		}
	}
}

