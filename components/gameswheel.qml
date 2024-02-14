import QtQuick 2.3
import QtMultimedia 5.15
import QtGraphicalEffects 1.15
import "qrc:/qmlutils" as PegasusUtils

FocusScope {
    id: gameswheel
	
	property var currentGame: currentCollection.games.get(gameAxis.currentIndex)
	property var titleContentHeight: gameTitle.contentHeight
	property var genreContentHeight: genre.contentHeight
	property var summaryContentHeight: gameSummary.contentHeight
	property var rating: (currentGame.rating * 5).toFixed(1)
	property string state: root.state
	property bool playing: false
		
	Rectangle {												
		width: parent.width
		height: parent.height
		anchors.fill: parent
		color: colorScheme[theme].background
	}
		
	ListView {											
		id: gameAxis
		
		model: currentCollection.games
		delegate: gameAxisDelegate
		
		width: parent.width / 3
		height: parent.height
		anchors.right: parent.right
		
		focus:true
		keyNavigationWraps: true		
		Keys.onPressed:{
			if (api.keys.isAccept(event))
			{
				currentGame.launch()
				event.accepted = true;
			}
			if (api.keys.isCancel(event))
			{
				root.state = 'collections'
				event.accepted = true;
			}
			if (api.keys.isFilters(event))
			{
				root.state = 'settings'
				event.accepted = true;
			}
		}
		
		preferredHighlightBegin : height * 0.5
		preferredHighlightEnd: height * 0.5
		
		spacing: vpx(144);
		
		snapMode: ListView.SnapOneItem
		highlightRangeMode: ListView.StrictlyEnforceRange
		highlightMoveDuration: 200
		
		Component {
			id: gameAxisDelegate

			Item {
				
				Text {
					anchors.centerIn: parent
					horizontalAlignment : Text.AlignHCenter
					verticalAlignment : Text.AlignVCenter
					width: 320
					text: modelData.title
					color: colorScheme[theme].text 
					font.family: globalFonts.sans
					font.pixelSize: index === gameAxis.currentIndex ? vpx (30) : vpx (15)
					font.bold: true
					wrapMode: Text.Wrap
					maximumLineCount: 3
					elide: Text.ElideRight
					opacity: index === gameAxis.currentIndex ? 1 : 0.3

					visible: !modelData.assets.logo 
				}
				
				Image {
					id: gameLogo

					width: index === gameAxis.currentIndex ? vpx (320) : vpx (160)
					height: index === gameAxis.currentIndex ? vpx (120) : vpx (50)
					anchors.verticalCenter: parent.verticalCenter
					anchors.horizontalCenter: parent.horizontalCenter
					fillMode: Image.PreserveAspectFit

					source: modelData.assets.logo

					asynchronous: true
					opacity: index === gameAxis.currentIndex ? 1 : 0.3
					visible: modelData.assets.logo

					MouseArea {											
						anchors.fill: parent
						onClicked: {
							gameAxis.currentIndex = index; 		
						}
					}
				}
			}
		}
	}	

		Item {															
			id: gameNameContainer
				anchors.right: parent.right
				anchors.rightMargin: vpx(640)
				anchors.verticalCenter: parent.verticalCenter

				
			Text {
				id: gameName
				
				text: currentGame.title
				color: colorScheme[theme].text 
				opacity: 0.5
				anchors.verticalCenter: parent.verticalCenter
				anchors.right: parent.right
				anchors.rightMargin: vpx(30)
				width: vpx(580)
				horizontalAlignment: Text.AlignRight
				font.family: globalFonts.sans
				font.pixelSize: vpx(30)
				font.bold: true
				wrapMode: Text.Wrap
				clip: true
			}
		}
		
		Item {															
			id: gameYearContainer
				width: parent.width * 1/6
				anchors.right: parent.right
				anchors.verticalCenter: parent.verticalCenter

				
			Text {
				id: gameYear
				
				text: currentGame.releaseYear ? currentGame.releaseYear : ""
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
				to: "gamesDetails"
				NumberAnimation { target: gameNameContainer; property: "opacity"; to: 0 ; duration: 250 }
				NumberAnimation { target: gameYearContainer; property: "opacity"; to: 0 ; duration: 250 }
				NumberAnimation { target: dividerLeft; property: "opacity"; to: 0 ; duration: 250 }
				NumberAnimation { target: dividerRight; property: "opacity"; to: 0 ; duration: 250 }
				NumberAnimation { target: gameAxis; property: "opacity"; to: 0 ; duration: 250 }
				SequentialAnimation {
					ParallelAnimation {
						NumberAnimation { target: videocontainer; property: "width"; to: vpx(738); duration: 500 }
						SequentialAnimation {
							PauseAnimation { duration: 300 }
							NumberAnimation { target: gamescreenshot; property: "opacity"; to: 1; duration: 200 }
						}	
					}
					ParallelAnimation {
						NumberAnimation { target: scrollbuttonsContainer; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: gamecovercontainer; property: "opacity"; to: 1; duration: 500 }
						NumberAnimation { target: gamecover; property: "anchors.leftMargin"; to: vpx(512) - vpx(40); duration: 500 }
						NumberAnimation { target: genreContainer; property: "opacity"; to: 1; duration: 500 }
						NumberAnimation { target: genreContainer; property: "anchors.leftMargin"; to: vpx(40); duration: 500 }
						NumberAnimation { target: gametitleContainer; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: gametitleRectangle; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: gametitleContainer; property: "anchors.leftMargin"; to: vpx(40); duration: 500 }
						NumberAnimation { target: gametitleRectangle; property: "width"; to: 0; duration: 500 }
						NumberAnimation { target: gameinfoContainer; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: gameinfoRect; property: "width"; to: vpx(400); duration: 500 }
					}
					ParallelAnimation {
						NumberAnimation { target: gameinfoAccent; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: gameinfoAccent; property: "width"; to: 10; duration: 500 }
						NumberAnimation { target: gameinfoDivider; property: "opacity"; to: 0.3; duration: 500 }
						NumberAnimation { target: gameinfoDivider; property: "anchors.topMargin"; to: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10) + vpx(10); duration: 500 }
						NumberAnimation { target: gamereleaseContainer; property: "opacity"; to: 1; duration: 500 }
						NumberAnimation { target: gamereleaseContainer; property: "anchors.topMargin"; to: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10); duration: 500 }
						NumberAnimation { target: ratingContainer; property: "opacity"; to: 1; duration: 500 }
						NumberAnimation { target: ratingContainer; property: "anchors.topMargin"; to: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10); duration: 500 }		
					}
					ParallelAnimation { 
						NumberAnimation { target: gamesummaryContainer; property: "opacity"; to: 1; duration: 500 }
						NumberAnimation { target: gamesummaryContainer; property: "anchors.topMargin"; to: parent.height/2 + vpx(10); duration: 500 }
					}
					PauseAnimation { duration: 4000 }
					ParallelAnimation {
						NumberAnimation { target: gamecovercontainer; property: "opacity"; to: 0; duration: 500 }
						NumberAnimation { target: gamecover; property: "anchors.leftMargin"; to: vpx(512) - vpx(120); duration: 500 }
					}
				}
			},
			Transition {
				to: "gamesSelection"
				NumberAnimation { target: gameNameContainer; property: "opacity"; to: 1 ; duration: 0 }
				NumberAnimation { target: gameYearContainer; property: "opacity"; to: 1 ; duration: 0 }
				NumberAnimation { target: dividerLeft; property: "opacity"; to: 0.3 ; duration: 0 }
				NumberAnimation { target: dividerRight; property: "opacity"; to: 0.3 ; duration: 0 }
				NumberAnimation { target: gameAxis; property: "opacity"; to: 1 ; duration: 0 }
				NumberAnimation { target: gamescreenshot; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: videocontainer; property: "width"; to: 0; duration: 0 }
				NumberAnimation { target: scrollbuttonsContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gamecovercontainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gamecover; property: "anchors.leftMargin"; to: vpx(512) - vpx(120); duration: 0 }
				NumberAnimation { target: gametitleContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gametitleRectangle; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gametitleContainer; property: "anchors.leftMargin"; to: vpx(0); duration: 0 }
				NumberAnimation { target: gametitleRectangle; property: "width"; to: vpx(482); duration: 0 }
				NumberAnimation { target: genreContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: genreContainer; property: "anchors.leftMargin"; to: vpx(0); duration: 0 }
				NumberAnimation { target: gamesummaryContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gamesummaryContainer; property: "anchors.topMargin"; to: parent.height/2 + vpx(30); duration: 0 }
				NumberAnimation { target: gameinfoContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoRect; property: "width"; to: vpx(0); duration: 0 }
				NumberAnimation { target: gameinfoAccent; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoAccent; property: "width"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoDivider; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoDivider; property: "anchors.topMargin"; to: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10) + vpx(10) + vpx(10); duration: 0 }
				NumberAnimation { target: gamereleaseContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gamereleaseContainer; property: "anchors.topMargin"; to: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10) + vpx(20); duration: 0 }		
				NumberAnimation { target: ratingContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: ratingContainer; property: "anchors.topMargin"; to: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10) + vpx(20); duration: 0 }		
			}
		]
	}
	
	Item {
		id: videocontainer
					
		width: parent.width * 0
		height: parent.height
		anchors.left: parent.left
		anchors.leftMargin: vpx(512)		
		anchors.top: parent.top
		anchors.topMargin: vpx(30)
		anchors.bottom: parent.bottom
		anchors.bottomMargin: vpx(30)
		
		Image {
			id: gamescreenshot
			
			anchors.fill: parent
			fillMode: Image.PreserveAspectFit
			source: currentGame.assets.screenshot
			opacity: 0
		}
		
		Loader {
			id: videoPreviewLoader
			asynchronous: true
			anchors { fill: parent }
		}
	}
	
	onCurrentGameChanged: {												
		videoPreviewLoader.sourceComponent = undefined;
		videoDelay.restart();
		scrollArea.restartScroll();
		scrollDelay.restart();
		transitions.state = "gamesSelection"
	}

	onPlayingChanged: {
		videoPreviewLoader.sourceComponent = undefined;
		videoDelay.restart();
		scrollArea.restartScroll();
		scrollDelay.restart();
		transitions.state = "gamesSelection"
	}

	onStateChanged: {
		videoPreviewLoader.sourceComponent = undefined;
		videoDelay.restart();
		scrollArea.restartScroll();
		scrollDelay.restart();
		transitions.state = "gamesSelection"
	}

	property string videoSource: currentGame.assets.video
	
	Timer {
		id: videoDelay

		interval: 1500
		onTriggered: {
			// if (currentGame && videoSource && root.state === 'gameswheel')
			if (currentGame && root.state === 'gameswheel')
			{
				videoPreviewLoader.sourceComponent = videoPreviewWrapper;
				transitions.state = "gamesDetails";
			}
		}
	}
	
	Timer {
		id: scrollDelay

		interval: 3000
		onTriggered: {
			if (currentGame && root.state === 'gameswheel')
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
		id: gametitleContainer
		height: parent.height / 2
		anchors.left: parent.left
		anchors.leftMargin: vpx(0)
		anchors.top: parent.top
		opacity: 0

		
		Text {
			id: gameTitle
			text: currentGame.title
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
		id: gametitleRectangle
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
		id: genreContainer
		width: vpx(400)
		anchors.left: parent.left
		anchors.leftMargin: vpx(0)
		anchors.top: parent.top
		anchors.topMargin: parent.height / 2 - titleContentHeight - genreContentHeight - vpx(10)
		opacity: 0
		
		Text {
			id: genre
			text: currentGame.genre
			color: collectiondata.getColor(currentCollection.shortName);
			font {
				pixelSize: vpx(20);
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
		id: gamesummaryContainer
		width: vpx(400)
		height: vpx(110)
		anchors.top: parent.top
		anchors.topMargin: parent.height/2 + vpx(30)
		anchors.left: parent.left
		anchors.leftMargin: vpx(40)
		opacity: 0

		PegasusUtils.AutoScroll {												
            id: scrollArea
			anchors.fill: parent
			Text {
				id: gameSummary
				text: currentGame.description
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
		id: gamecovercontainer
		anchors.fill: parent
		opacity: 0
		
		Image {
			id: gamecover									
			width: vpx(250)
			fillMode: Image.PreserveAspectFit
			source: currentGame.assets.boxFront
			asynchronous: true

			anchors.left: parent.left
			anchors.leftMargin: vpx(512) - vpx(120)
			anchors.verticalCenter: parent.verticalCenter
		}
	
		DropShadow {
			id: gamecoverShadow
			anchors.fill: gamecover
			horizontalOffset: -1
			verticalOffset: 5
			radius: 8
			samples: 17
			color: "#aa000000"
			source: gamecover
		}
	}
	
	Item {									
		id: gameinfoContainer
		opacity: 0
		
		Rectangle {
			id: gameinfoRect
			height: vpx(120)
			width: vpx(0)
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
		id: gameinfoDivider
		height: vpx(100)
		width: vpx(2)
		anchors.left: parent.left
		anchors.leftMargin: vpx(239)
		anchors.top: parent.top
		anchors.topMargin: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10) + vpx(10) + vpx (10)
		color: colorScheme[theme].text 
		opacity: 0
	}
	
	Item {
		id: gamereleaseContainer
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
			source: "../assets/images/icons/Colorful_IconDate.png"
		}
		
		Text{
			text: currentGame.releaseYear
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
			text: "Release"
			color: colorScheme[theme].text //"gray"
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
		id: ratingContainer
		
		anchors.top: parent.top
		anchors.topMargin: vpx(360) + vpx(10) + (summaryContentHeight > vpx(120) ? vpx(120) : summaryContentHeight) + vpx(10) + vpx(20)
		anchors.left: parent.left
		anchors.leftMargin: vpx(241)
		
		opacity: 0
		
		Text {
			text: rating
			anchors.top: parent.top
			anchors.topMargin: vpx (10)
			anchors.left: parent.left
			color: colorScheme[theme].text
			opacity: 0.3
			font.family: globalFonts.sans
			font.pixelSize: vpx(20)
			font.bold: true
			width: vpx(189)
			height: vpx(26)
			horizontalAlignment : Text.AlignHCenter
			verticalAlignment : Text.AlignVCenter
		}
				
		Image{
			id: ratingstars
			anchors.top: parent.top
			anchors.topMargin: vpx (30)
			anchors.left: parent.left
			anchors.leftMargin: vpx(30)
			width: vpx(129)
			height: vpx(60)
			horizontalAlignment : Image.AlignHCenter
			verticalAlignment : Image.AlignVCenter
			fillMode: Image.PreserveAspectFit
			source: "../assets/images/stars/" + rating + ".png"
		}
		ColorOverlay {
			anchors.fill: ratingstars
			source: ratingstars
			color: collectiondata.getColor(currentCollection.shortName);
		}
		
		Text{
			text: "Rating"
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