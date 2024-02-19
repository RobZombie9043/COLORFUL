import QtQuick 2.3
import QtMultimedia 5.15
import QtGraphicalEffects 1.15
import "qrc:/qmlutils" as PegasusUtils
import SortFilterProxyModel 0.2

FocusScope {
    id: collections
	
	property var currentCollection: allCollections[currentCollectionIndex]
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
		
		model: allCollections
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
				videoPreviewLoader.sourceComponent = undefined;
				}
			}
		}
		
		preferredHighlightBegin : height * 0.5
		preferredHighlightEnd: height * 0.5
		
		spacing: scaleItem(144);
		
		snapMode: ListView.SnapToItem
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
					width: scaleItem(320)
					text: modelData.name
					color: colorScheme[theme].text 
					font.family: globalFonts.sans
					font.pixelSize: index === collectionAxis.currentIndex ? scaleItem (30) : scaleItem (15)
					font.bold: true
					wrapMode: Text.Wrap
					maximumLineCount: 3
					elide: Text.ElideRight
					opacity: index === collectionAxis.currentIndex ? 1 : 0.3

					visible: false
				}
			
				Image {
					id: collectionLogo

					width: index === collectionAxis.currentIndex ? scaleItem (320) : scaleItem (160)
					height: index === collectionAxis.currentIndex ? scaleItem (120) : scaleItem (50)
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
			anchors.rightMargin: scaleItem(30)
			font.family: globalFonts.sans
			font.pixelSize: scaleItem(30)
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
			anchors.leftMargin: scaleItem(30)
			font.family: globalFonts.sans
			font.pixelSize: scaleItem(30)
			font.bold: true
		}
	}
	
	Rectangle {												
		id: dividerRight
		width: scaleItem (2)
		height: scaleItem (40)
		anchors.right: parent.right
		anchors.rightMargin: parent.width / 6
		anchors.verticalCenter: parent.verticalCenter
		color: colorScheme[theme].text 
		opacity: 0.3
	}
	
	Rectangle {											
		id: dividerLeft
		width: scaleItem (2)
		height: scaleItem (40)
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
						NumberAnimation { target: videocontainer; property: "width"; to: scaleItem(730); duration: 500 }
						NumberAnimation { target: videocontainer; property: "anchors.leftMargin"; to: scaleItem(520); duration: 500 }
					}
					ParallelAnimation {
						NumberAnimation { target: collectiondeviceimage; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: scrollbuttonsContainer; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: vendoryearContainer; property: "opacity"; to: 1; duration: 500 }
						NumberAnimation { target: vendoryearContainer; property: "anchors.leftMargin"; to: scaleItem(40); duration: 500 }
					}
					ParallelAnimation { 
						NumberAnimation { target: collectiontitleContainer; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: collectiontitleRectangle; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: collectiontitleContainer; property: "anchors.leftMargin"; to: scaleItem(40); duration: 500 }
						NumberAnimation { target: collectiontitleRectangle; property: "width"; to: 0; duration: 500 }
					}
					ParallelAnimation { 
						NumberAnimation { target: collectionsummaryContainer; property: "opacity"; to: 1; duration: 500 }
						NumberAnimation { target: collectionsummaryContainer; property: "anchors.leftMargin"; to: scaleItem(40); duration: 500 }
					}
					ParallelAnimation {
						NumberAnimation { target: gameinfoContainer; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: gameinfoRect; property: "width"; to: scaleItem(560); duration: 500 }
						SequentialAnimation {
							PauseAnimation { duration: 250 }
							ParallelAnimation {
								NumberAnimation { target: gameinfoRectColour; property: "opacity"; to: 1; duration: 0 }
								NumberAnimation { target: gameinfoRectColour; property: "width"; to: scaleItem(160); duration: 500 }
								NumberAnimation { target: gameinfoAccent; property: "opacity"; to: 1; duration: 0 }
								NumberAnimation { target: gameinfoAccent; property: "width"; to: 10; duration: 500 }
								NumberAnimation { target: gameinfoDivider; property: "opacity"; to: 0.3; duration: 500 }
								NumberAnimation { target: gameinfoDivider; property: "anchors.topMargin"; to: scaleItem(360) + scaleItem(10) + (summaryContentHeight > scaleItem(120) ? scaleItem(120) : summaryContentHeight) + scaleItem(10) + scaleItem(10); duration: 500 }
								SequentialAnimation {
									PauseAnimation { duration: 250 }
									ParallelAnimation {
										NumberAnimation { target: gamescountContainer; property: "opacity"; to: 1; duration: 500 }
										NumberAnimation { target: gamescountContainer; property: "anchors.topMargin"; to: scaleItem(360) + scaleItem(10) + (summaryContentHeight > scaleItem(120) ? scaleItem(120) : summaryContentHeight) + scaleItem(10); duration: 500 }										
										NumberAnimation { target: favouritescountContainer; property: "opacity"; to: 1; duration: 500 }
										NumberAnimation { target: favouritescountContainer; property: "anchors.topMargin"; to: scaleItem(360) + scaleItem(10) + (summaryContentHeight > scaleItem(120) ? scaleItem(120) : summaryContentHeight) + scaleItem(10); duration: 500 }		
										NumberAnimation { target: pressxContainer; property: "opacity"; to: 1; duration: 500 }
										NumberAnimation { target: pressxContainer; property: "anchors.topMargin"; to: scaleItem(360) + scaleItem(10) + (summaryContentHeight > scaleItem(120) ? scaleItem(120) : summaryContentHeight) + scaleItem(10); duration: 500 }		
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
				NumberAnimation { target: videocontainer; property: "anchors.leftMargin"; to: scaleItem(0); duration: 0 }
				NumberAnimation { target: collectiondeviceimage; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: scrollbuttonsContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: collectiontitleContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: collectiontitleRectangle; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: collectiontitleContainer; property: "anchors.leftMargin"; to: scaleItem(0); duration: 0 }
				NumberAnimation { target: collectiontitleRectangle; property: "width"; to: scaleItem(482); duration: 0 }
				NumberAnimation { target: gameinfoContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: vendoryearContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: vendoryearContainer; property: "anchors.leftMargin"; to: scaleItem(0); duration: 0 }
				NumberAnimation { target: collectionsummaryContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: collectionsummaryContainer; property: "anchors.leftMargin"; to: scaleItem(0); duration: 0 }
				NumberAnimation { target: gameinfoRect; property: "width"; to: scaleItem(400); duration: 0 }
				NumberAnimation { target: gameinfoRectColour; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoRectColour; property: "width"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoAccent; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoAccent; property: "width"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoDivider; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoDivider; property: "anchors.topMargin"; to: scaleItem(360) + scaleItem(10) + (summaryContentHeight > scaleItem(120) ? scaleItem(120) : summaryContentHeight) + scaleItem(10) + scaleItem(10) + scaleItem(10); duration: 0 }
				NumberAnimation { target: gamescountContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gamescountContainer; property: "anchors.topMargin"; to: scaleItem(360) + scaleItem(10) + (summaryContentHeight > scaleItem(120) ? scaleItem(120) : summaryContentHeight) + scaleItem(10) + scaleItem(20); duration: 0 }		
				NumberAnimation { target: favouritescountContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: favouritescountContainer; property: "anchors.topMargin"; to: scaleItem(360) + scaleItem(10) + (summaryContentHeight > scaleItem(120) ? scaleItem(120) : summaryContentHeight) + scaleItem(10) + scaleItem(20); duration: 0 }		
				NumberAnimation { target: pressxContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: pressxContainer; property: "anchors.topMargin"; to: scaleItem(360) + scaleItem(10) + (summaryContentHeight > scaleItem(120) ? scaleItem(120) : summaryContentHeight) + scaleItem(10) + scaleItem(20); duration: 0 }		
			}
		]
	}

	Item {
		id: videocontainer
					
		width: parent.width * 0
		height: parent.height
		anchors.left: parent.left
		anchors.leftMargin: scaleItem(0)		
		anchors.top: parent.top
		anchors.topMargin: scaleItem(30)
		anchors.bottom: parent.bottom
		anchors.bottomMargin: scaleItem(30)

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
			opacity: 0
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
			visible: videoSource && videoplaycollections
			muted: videosound
		}
	}

	
	Item {
		id: collectiontitleContainer
		height: parent.height / 2
		anchors.left: parent.left
		anchors.leftMargin: scaleItem(0)
		anchors.top: parent.top
		opacity: 0

		
		Text {
			id: collectionTitle
			text: currentCollection.name
			color: colorScheme[theme].text 
			font.family: globalFonts.sans
			font.pixelSize: scaleItem(45)
			font.bold: true
			width: scaleItem(400)
			wrapMode: Text.Wrap
			verticalAlignment : Text.AlignBottom
			anchors.bottom: parent.bottom
			clip: true
		}
	}
	
	Rectangle {
		id: collectiontitleRectangle
		height: titleContentHeight
		width: scaleItem(400)
		anchors.right: parent.right
		anchors.rightMargin: scaleItem(840)
		anchors.bottom: parent.bottom
		anchors.bottomMargin: parent.height/2
		color: colorScheme[theme].background 
		opacity: 0
	}
	
	Item {
		id: vendoryearContainer
		width: scaleItem(400)
		anchors.left: parent.left
		anchors.leftMargin: scaleItem(0)
		anchors.top: parent.top
		anchors.topMargin: parent.height / 2 - titleContentHeight - vendorYearContentHeight - scaleItem(10)
		opacity: 0
		
		Text {
			id: vendorYear
			text: collectiondata.getVendorYear(currentCollection.shortName);
			color: collectiondata.getColor(currentCollection.shortName);
			font {
				capitalization: Font.AllUppercase;
				pixelSize: scaleItem(30);
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
		width: scaleItem(400)
		height: scaleItem(112)
		anchors.top: parent.top
		anchors.topMargin: parent.height/2 + scaleItem(10)
		anchors.left: parent.left
		anchors.leftMargin: scaleItem(0)   
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
					pixelSize: scaleItem(15);
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
			height: scaleItem(120)
			width: scaleItem(400)
			anchors.left: parent.left
			anchors.leftMargin: scaleItem(40)
			anchors.top: parent.top
			anchors.topMargin: scaleItem(360) + scaleItem(10) + (summaryContentHeight > scaleItem(120) ? scaleItem(120) : summaryContentHeight) + scaleItem(10)
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
		height: scaleItem(120)
		width: scaleItem(0)
		anchors.left: parent.left
		anchors.leftMargin: scaleItem(40)
		anchors.top: parent.top
		anchors.topMargin: scaleItem(360) + scaleItem(10) + (summaryContentHeight > scaleItem(120) ? scaleItem(120) : summaryContentHeight) + scaleItem(10)
		color: collectiondata.getColor(currentCollection.shortName)
		opacity: 0
	}
	
								
	Rectangle {								
		id: gameinfoRectColour
		height: scaleItem(120)
		width: scaleItem(0)
		anchors.left: parent.left
		anchors.leftMargin: scaleItem(440)
		anchors.top: parent.top
		anchors.topMargin: scaleItem(360) + scaleItem(10) + (summaryContentHeight > scaleItem(120) ? scaleItem(120) : summaryContentHeight) + scaleItem(10)
		color: collectiondata.getColor(currentCollection.shortName)
		opacity: 0
	}
	
	
	Rectangle {								
		id: gameinfoDivider
		height: scaleItem(100)
		width: scaleItem(2)
		anchors.left: parent.left
		anchors.leftMargin: scaleItem(239)
		anchors.top: parent.top
		anchors.topMargin: scaleItem(360) + scaleItem(10) + (summaryContentHeight > scaleItem(120) ? scaleItem(120) : summaryContentHeight) + scaleItem(10) + scaleItem(10) + scaleItem(10)
		color: colorScheme[theme].text 
		opacity: 0
	}
	
	
	Item {
		id: gamescountContainer
		anchors.top: parent.top
		anchors.topMargin: scaleItem(360) + scaleItem(10) + (summaryContentHeight > scaleItem(120) ? scaleItem(120) : summaryContentHeight) + scaleItem(10) + scaleItem(20)
		anchors.left: parent.left
		anchors.leftMargin: scaleItem(50)
		
		opacity: 0
		
		Image {
			anchors.top: parent.top
			anchors.topMargin: -scaleItem (5)
			anchors.left: parent.left
			width: scaleItem(189)
			height: scaleItem(50)
			horizontalAlignment : Image.AlignHCenter
			verticalAlignment : Image.AlignVCenter
			fillMode: Image.PreserveAspectFit
			source: "../assets/images/icons/Colorful_IconGames.png"
		}
		
		Text{
			text: currentCollection.games.count
			color: collectiondata.getColor(currentCollection.shortName);
			font.family: globalFonts.sans
			font.pixelSize: scaleItem(30)
			font.bold: true
			anchors.top: parent.top
			anchors.topMargin: scaleItem (30)
			anchors.left: parent.left
			width: scaleItem(189)
			height: scaleItem(60)
			horizontalAlignment : Text.AlignHCenter
			verticalAlignment : Text.AlignVCenter
		}
		
		Text{
			text: "Games"
			color: colorScheme[theme].text 
			font.family: globalFonts.sans
			font.pixelSize: scaleItem(15)
			font.bold: true
			opacity: 0.3
			anchors.top: parent.top
			anchors.topMargin: scaleItem (70)
			anchors.left: parent.left
			width: scaleItem(189)
			height: scaleItem(50)
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
		anchors.topMargin: scaleItem(360) + scaleItem(10) + (summaryContentHeight > scaleItem(120) ? scaleItem(120) : summaryContentHeight) + scaleItem(10) + scaleItem(20)
		anchors.left: parent.left
		anchors.leftMargin: scaleItem(241)
		
		opacity: 0
		
		Image {
			anchors.top: parent.top
			anchors.topMargin: scaleItem (10)
			anchors.left: parent.left
			width: scaleItem(189)
			height: scaleItem(26)
			horizontalAlignment : Image.AlignHCenter
			verticalAlignment : Image.AlignVCenter
			fillMode: Image.PreserveAspectFit
			source: "../assets/images/icons/Colorful_IconFav.png"
		}
		
		Text{
			text: favouritesProxyModel.count
			color: collectiondata.getColor(currentCollection.shortName);
			font.family: globalFonts.sans
			font.pixelSize: scaleItem(30)
			font.bold: true
			anchors.top: parent.top
			anchors.topMargin: scaleItem (30)
			anchors.left: parent.left
			width: scaleItem(189)
			height: scaleItem(60)
			horizontalAlignment : Text.AlignHCenter
			verticalAlignment : Text.AlignVCenter
		}
		
		Text{
			text: "Favourites"
			color: colorScheme[theme].text 
			font.family: globalFonts.sans
			font.pixelSize: scaleItem(15)
			font.bold: true
			opacity: 0.3
			anchors.top: parent.top
			anchors.topMargin: scaleItem (70)
			anchors.left: parent.left
			width: scaleItem(189)
			height: scaleItem(50)
			horizontalAlignment : Text.AlignHCenter
			verticalAlignment : Text.AlignVCenter
		}
	}
	
	Item {
		id: pressxContainer
		anchors.top: parent.top
		anchors.topMargin: scaleItem(360) + scaleItem(10) + (summaryContentHeight > scaleItem(120) ? scaleItem(120) : summaryContentHeight) + scaleItem(10) + scaleItem(20)
		anchors.left: parent.left
		anchors.leftMargin: scaleItem(440)
		
		opacity: 0
		
		Image {
			anchors.top: parent.top
			anchors.left: parent.left
			width: scaleItem(160)
			height: scaleItem(120)
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
		anchors.rightMargin: scaleItem(30)		
		anchors.bottom: parent.bottom
		anchors.bottomMargin: scaleItem(30)
		color: colorScheme[theme].background 
		
		opacity: 0
		
		AnimatedImage {
			anchors.bottom: parent.bottom
			anchors.right: parent.right
			width: scaleItem(80)
			fillMode: Image.PreserveAspectFit
			source: "../assets/images/icons/Colorful_PlatformWheel_Arrows_Vertical_type2.gif"
		}
	}
}

