import QtQuick 2.3
import QtMultimedia 5.15
import QtGraphicalEffects 1.15
import "qrc:/qmlutils" as PegasusUtils
import SortFilterProxyModel 0.2

FocusScope {
    id: gameswheel
	
	property var titleContentHeight: gameTitle.contentHeight
	property var genreContentHeight: genre.contentHeight
	property var summaryContentHeight: gameSummary.contentHeight
	property var rating: (currentGame.rating * 5).toFixed(1)
	property bool playing: false
	property bool favoritesFiltered: false
		
	Rectangle {												
		width: parent.width
		height: parent.height
		anchors.fill: parent
		color: colorScheme[theme].background
	}
		
	ListView {											
		id: gameAxis
		
		model: filteredGames
		delegate: gameAxisDelegate
		
		width: parent.width / 3
		height: parent.height
		anchors.right: parent.right
		
		focus:true
		keyNavigationWraps: true	
		
		Keys.onPressed:{
			 // A weird issue where when you launch a game it spams auto repeat when Pegasus loads back
            if (event.isAutoRepeat) {
                return
            }
			if (api.keys.isAccept(event))
			{
				event.accepted = true;
				currentGame.launch()
			}
			if (api.keys.isCancel(event))
			{
				if (transitions.state === 'gamesDetails') {
				event.accepted = true;
				transitions.state = 'gamesSelection';
				videoPreviewLoader.sourceComponent = undefined;
				} else {
				event.accepted = true;
				root.state = 'collections'
				}
			}
			if (api.keys.isDetails(event))
			{
				event.accepted = true;
				currentGame.favorite = !currentGame.favorite;
			}
			if (api.keys.isFilters(event)) 
			{
				event.accepted = true;
				favoritesFiltered = !favoritesFiltered
			}
			if (event.key == 1048586)
			{
				event.accepted = true;
				api.memory.set('prevView', gamesview);
				root.state = 'settings'
			}
		}
		
		Keys.onReleased: {
			if (api.keys.isPageDown(event)) {
				event.accepted = true;
				if (currentCollectionIndex >= api.collections.count - 1) {
					currentCollectionIndex = 0;
				} else {
					currentCollectionIndex++;
				}
				return;
			}
			
			if (api.keys.isPageUp(event)) {
				event.accepted = true;
				if (currentCollectionIndex <= 0) {
					currentCollectionIndex = api.collections.count - 1;;
				} else {
					currentCollectionIndex--;
				}
				return;
			}
        }
		
		preferredHighlightBegin : height * 0.5
		preferredHighlightEnd: height * 0.5
		
		currentIndex: currentGameIndex
        onCurrentIndexChanged: currentGameIndex = currentIndex
		
		spacing: scaleItemHeight(144);
		
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
					font.pixelSize: index === gameAxis.currentIndex ? scaleItemHeight (30) : scaleItemHeight (15)
					font.bold: true
					wrapMode: Text.Wrap
					maximumLineCount: 3
					elide: Text.ElideRight
					opacity: index === gameAxis.currentIndex ? 1 : 0.3

					visible: !modelData.assets.logo 
				}
				
				Image {
					id: gameLogo

					width: index === gameAxis.currentIndex ? scaleItemWidth (320) : scaleItemWidth (160)
					height: index === gameAxis.currentIndex ? scaleItemHeight (120) : scaleItemHeight (50)
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
				anchors.rightMargin: parent.width / 2
				anchors.verticalCenter: parent.verticalCenter
				visible: currentGame !== null

				
			Text {
				id: gameName
				
				text: currentGame.title
				color: colorScheme[theme].text 
				opacity: 0.5
				anchors.verticalCenter: parent.verticalCenter
				anchors.right: parent.right
				anchors.rightMargin: scaleItemWidth(30)
				width: scaleItemWidth(580)
				horizontalAlignment: Text.AlignRight
				font.family: globalFonts.sans
				font.pixelSize: scaleItemHeight(30)
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
				visible: currentGame !== null

				
			Text {
				id: gameYear
				
				text: currentGame.releaseYear ? currentGame.releaseYear : ""
				color: colorScheme[theme].text 
				opacity: 0.5
				anchors.verticalCenter: parent.verticalCenter
				anchors.left: parent.left
				anchors.leftMargin: scaleItemWidth(30)
				font.family: globalFonts.sans
				font.pixelSize: scaleItemHeight(30)
				font.bold: true
			}
		}
		
		Rectangle {										
			id: dividerRight
			width: scaleItemWidth (2)
			height: scaleItemHeight (40)
			anchors.right: parent.right
			anchors.rightMargin: parent.width / 6
			anchors.verticalCenter: parent.verticalCenter
			color: colorScheme[theme].text 
			opacity: 0.3
			visible: currentGame !== null
		}
		
		Rectangle {											
			id: dividerLeft
			width: scaleItemWidth (2)
			height: scaleItemHeight (40)
			anchors.right: parent.right
			anchors.rightMargin: parent.width / 2
			anchors.verticalCenter: parent.verticalCenter
			color: colorScheme[theme].text 
			opacity: 0.3
			visible: currentGame !== null
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
						NumberAnimation { target: videocontainer; property: "width"; to: scaleItemWidth(738); duration: 500 }
						SequentialAnimation {
							PauseAnimation { duration: 300 }
							NumberAnimation { target: gamescreenshot; property: "opacity"; to: 1; duration: 200 }
						}	
					}
					ParallelAnimation {
						NumberAnimation { target: scrollbuttonsContainer; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: gamecovercontainer; property: "opacity"; to: 1; duration: 500 }
						NumberAnimation { target: gamecover; property: "anchors.leftMargin"; to: scaleItemWidth(512) - scaleItemWidth(40); duration: 500 }
						NumberAnimation { target: genreContainer; property: "opacity"; to: 1; duration: 500 }
						NumberAnimation { target: genreContainer; property: "anchors.leftMargin"; to: scaleItemWidth(40); duration: 500 }
						NumberAnimation { target: gametitleContainer; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: gametitleRectangle; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: gametitleContainer; property: "anchors.leftMargin"; to: scaleItemWidth(40); duration: 500 }
						NumberAnimation { target: gametitleRectangle; property: "width"; to: 0; duration: 500 }
						NumberAnimation { target: gameinfoContainer; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: gameinfoRect; property: "width"; to: scaleItemWidth(400); duration: 500 }
					}
					ParallelAnimation {
						NumberAnimation { target: gameinfoAccent; property: "opacity"; to: 1; duration: 0 }
						NumberAnimation { target: gameinfoAccent; property: "width"; to: 10; duration: 500 }
						NumberAnimation { target: gameinfoDivider; property: "opacity"; to: 0.3; duration: 500 }
						NumberAnimation { target: gameinfoDivider; property: "anchors.topMargin"; to: scaleItemHeight(360) + scaleItemHeight(10) + (summaryContentHeight > scaleItemHeight(120) ? scaleItemHeight(120) : summaryContentHeight) + scaleItemHeight(10) + scaleItemHeight(10); duration: 500 }
						NumberAnimation { target: gamereleaseContainer; property: "opacity"; to: 1; duration: 500 }
						NumberAnimation { target: gamereleaseContainer; property: "anchors.topMargin"; to: scaleItemHeight(360) + scaleItemHeight(10) + (summaryContentHeight > scaleItemHeight(120) ? scaleItemHeight(120) : summaryContentHeight) + scaleItemHeight(10); duration: 500 }
						NumberAnimation { target: ratingContainer; property: "opacity"; to: 1; duration: 500 }
						NumberAnimation { target: ratingContainer; property: "anchors.topMargin"; to: scaleItemHeight(360) + scaleItemHeight(10) + (summaryContentHeight > scaleItemHeight(120) ? scaleItemHeight(120) : summaryContentHeight) + scaleItemHeight(10); duration: 500 }		
						NumberAnimation { target: favoriteiconContainer; property: "opacity"; to: 1; duration: 500 }
						NumberAnimation { target: favoriteiconContainer; property: "anchors.topMargin"; to: parent.height / 2 - titleContentHeight - genreContentHeight - scaleItemHeight(10) - scaleItemHeight(30)- scaleItemHeight(20); duration: 500 }		
					}
					ParallelAnimation { 
						NumberAnimation { target: gamesummaryContainer; property: "opacity"; to: 1; duration: 500 }
						NumberAnimation { target: gamesummaryContainer; property: "anchors.topMargin"; to: parent.height/2 + scaleItemHeight(10); duration: 500 }
					}
					PauseAnimation { duration: 4000 }
					ParallelAnimation {
						NumberAnimation { target: gamecovercontainer; property: "opacity"; to: 0; duration: 500 }
						NumberAnimation { target: gamecover; property: "anchors.leftMargin"; to: scaleItemWidth(512) - scaleItemWidth(120); duration: 500 }
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
				NumberAnimation { target: gamecover; property: "anchors.leftMargin"; to: scaleItemWidth(512) - scaleItemWidth(120); duration: 0 }
				NumberAnimation { target: gametitleContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gametitleRectangle; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gametitleContainer; property: "anchors.leftMargin"; to: scaleItemWidth(0); duration: 0 }
				NumberAnimation { target: gametitleRectangle; property: "width"; to: scaleItemWidth(482); duration: 0 }
				NumberAnimation { target: genreContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: genreContainer; property: "anchors.leftMargin"; to: scaleItemWidth(0); duration: 0 }
				NumberAnimation { target: gamesummaryContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gamesummaryContainer; property: "anchors.topMargin"; to: parent.height/2 + scaleItemHeight(30); duration: 0 }
				NumberAnimation { target: gameinfoContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoRect; property: "width"; to: scaleItemWidth(0); duration: 0 }
				NumberAnimation { target: gameinfoAccent; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoAccent; property: "width"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoDivider; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gameinfoDivider; property: "anchors.topMargin"; to: scaleItemHeight(360) + scaleItemHeight(10) + (summaryContentHeight > scaleItemHeight(120) ? scaleItemHeight(120) : summaryContentHeight) + scaleItemHeight(10) + scaleItemHeight(10) + scaleItemHeight(10); duration: 0 }
				NumberAnimation { target: gamereleaseContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: gamereleaseContainer; property: "anchors.topMargin"; to: scaleItemHeight(360) + scaleItemHeight(10) + (summaryContentHeight > scaleItemHeight(120) ? scaleItemHeight(120) : summaryContentHeight) + scaleItemHeight(10) + scaleItemHeight(20); duration: 0 }		
				NumberAnimation { target: ratingContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: ratingContainer; property: "anchors.topMargin"; to: scaleItemHeight(360) + scaleItemHeight(10) + (summaryContentHeight > scaleItemHeight(120) ? scaleItemHeight(120) : summaryContentHeight) + scaleItemHeight(10) + scaleItemHeight(20); duration: 0 }		
				NumberAnimation { target: favoriteiconContainer; property: "opacity"; to: 0; duration: 0 }
				NumberAnimation { target: favoriteiconContainer; property: "anchors.topMargin"; to: parent.height / 2 - titleContentHeight - genreContentHeight - scaleItemHeight(10) - scaleItemHeight(30); duration: 500 }		
			}
		]
	}
	
	Item {
		id: videocontainer
					
		width: parent.width * 0
		height: parent.height
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(512)		
		anchors.top: parent.top
		anchors.topMargin: scaleItemHeight(30)
		anchors.bottom: parent.bottom
		anchors.bottomMargin: scaleItemHeight(30)
		
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

	property string musicSource: currentGame.assets.music

	Component {
		id: videoPreviewWrapper

		Video {
			id: videocomponent
				
			source: videoSource ?? ""
			fillMode: VideoOutput.PreserveAspectCrop
			loops: MediaPlayer.Infinite
			autoPlay: true
			visible: videoSource && videoplaygames
			muted: (musicSource && musicsound) || videosound
			Audio {
				id: musicPlayer

				autoPlay: true
				muted: !musicsound
				loops: MediaPlayer.Infinite
				source: musicSource
			}
		}

	}
	
	Item {
		id: gametitleContainer
		height: parent.height / 2
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(0)
		anchors.top: parent.top
		opacity: 0

		
		Text {
			id: gameTitle
			text: currentGame.title
			color: colorScheme[theme].text
			font.family: globalFonts.sans
			font.pixelSize: scaleItemHeight(45)
			font.bold: true
			width: scaleItemWidth(400)
			wrapMode: Text.Wrap
			verticalAlignment : Text.AlignBottom
			anchors.bottom: parent.bottom
			clip: true
		}
	}
	
	Rectangle {
		id: gametitleRectangle
		height: titleContentHeight
		width: scaleItemWidth(400)
		anchors.right: parent.right
		anchors.rightMargin: scaleItemWidth(840)
		anchors.bottom: parent.bottom
		anchors.bottomMargin: parent.height/2
		color: colorScheme[theme].background 
		opacity: 0
	}
	
	Item {
		id: genreContainer
		width: scaleItemWidth(400)
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(0)
		anchors.top: parent.top
		anchors.topMargin: parent.height / 2 - titleContentHeight - genreContentHeight - scaleItemHeight(10)
		opacity: 0
		
		Text {
			id: genre
			text: currentGame.genre
			color: collectiondata.getColor(currentCollection.shortName);
			font {
				pixelSize: scaleItemHeight(20);
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
		id: favoriteiconContainer
		width: scaleItemWidth(30)
		height: scaleItemHeight(30)
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(40)
		anchors.top: parent.top
		anchors.topMargin: parent.height / 2 - titleContentHeight - genreContentHeight - scaleItemHeight(10) - scaleItemHeight(30)- scaleItemHeight(20)
		opacity: 0
			
		Image {
			id: favoriteicon
			anchors.fill: parent
			source: "../assets/images/icons/Colorful_IconFav.png"
			opacity: currentGame.favorite
		}
		
		ColorOverlay {
			anchors.fill: favoriteicon
			source: favoriteicon
			color: colorScheme[theme].text
			opacity: currentGame.favorite
		}
	}
	
	Item {
		id: gamesummaryContainer
		width: scaleItemWidth(400)
		height: scaleItemHeight(110)
		anchors.top: parent.top
		anchors.topMargin: parent.height/2 + scaleItemHeight(30)
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(40)
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
					pixelSize: scaleItemHeight(15);
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
			width: scaleItemWidth(250)
			fillMode: Image.PreserveAspectFit
			source: currentGame.assets.boxFront
			asynchronous: true

			anchors.left: parent.left
			anchors.leftMargin: scaleItemWidth(512) - scaleItemWidth(120)
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
			height: scaleItemHeight(120)
			width: scaleItemWidth(0)
			anchors.left: parent.left
			anchors.leftMargin: scaleItemWidth(40)
			anchors.top: parent.top
			anchors.topMargin: scaleItemHeight(360) + scaleItemHeight(10) + (summaryContentHeight > scaleItemHeight(120) ? scaleItemHeight(120) : summaryContentHeight) + scaleItemHeight(10)
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
		height: scaleItemHeight(120)
		width: scaleItemWidth(0)
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(40)
		anchors.top: parent.top
		anchors.topMargin: scaleItemHeight(360) + scaleItemHeight(10) + (summaryContentHeight > scaleItemHeight(120) ? scaleItemHeight(120) : summaryContentHeight) + scaleItemHeight(10)
		color: collectiondata.getColor(currentCollection.shortName)
		opacity: 0
	}

	Rectangle {							
		id: gameinfoDivider
		height: scaleItemHeight(100)
		width: scaleItemWidth(2)
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(239)
		anchors.top: parent.top
		anchors.topMargin: scaleItemHeight(360) + scaleItemHeight(10) + (summaryContentHeight > scaleItemHeight(120) ? scaleItemHeight(120) : summaryContentHeight) + scaleItemHeight(10) + scaleItemHeight(10) + scaleItemHeight (10)
		color: colorScheme[theme].text 
		opacity: 0
	}
	
	Item {
		id: gamereleaseContainer
		anchors.top: parent.top
		anchors.topMargin: scaleItemHeight(360) + scaleItemHeight(10) + (summaryContentHeight > scaleItemHeight(120) ? scaleItemHeight(120) : summaryContentHeight) + scaleItemHeight(10) + scaleItemHeight(20)
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(50)
		
		opacity: 0
		
		Image {
			anchors.top: parent.top
			anchors.topMargin: -scaleItemHeight (5)
			anchors.left: parent.left
			width: scaleItemWidth(189)
			height: scaleItemHeight(50)
			horizontalAlignment : Image.AlignHCenter
			verticalAlignment : Image.AlignVCenter
			fillMode: Image.PreserveAspectFit
			source: "../assets/images/icons/Colorful_IconDate.png"
		}
		
		Text{
			text: currentGame.releaseYear
			color: collectiondata.getColor(currentCollection.shortName);
			font.family: globalFonts.sans
			font.pixelSize: scaleItemHeight(30)
			font.bold: true
			anchors.top: parent.top
			anchors.topMargin: scaleItemHeight (30)
			anchors.left: parent.left
			width: scaleItemWidth(189)
			height: scaleItemHeight(60)
			horizontalAlignment : Text.AlignHCenter
			verticalAlignment : Text.AlignVCenter
		}
		
		Text{
			text: "Release"
			color: colorScheme[theme].text
			font.family: globalFonts.sans
			font.pixelSize: scaleItemHeight(15)
			font.bold: true
			opacity: 0.3
			anchors.top: parent.top
			anchors.topMargin: scaleItemHeight (70)
			anchors.left: parent.left
			width: scaleItemWidth(189)
			height: scaleItemHeight(50)
			horizontalAlignment : Text.AlignHCenter
			verticalAlignment : Text.AlignVCenter
		}
	}
	
	Item {
		id: ratingContainer
		
		anchors.top: parent.top
		anchors.topMargin: scaleItemHeight(360) + scaleItemHeight(10) + (summaryContentHeight > scaleItemHeight(120) ? scaleItemHeight(120) : summaryContentHeight) + scaleItemHeight(10) + scaleItemHeight(20)
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(241)
		
		opacity: 0
		
		Text {
			text: rating
			anchors.top: parent.top
			anchors.topMargin: scaleItemHeight (10)
			anchors.left: parent.left
			color: colorScheme[theme].text
			opacity: 0.3
			font.family: globalFonts.sans
			font.pixelSize: scaleItemHeight(20)
			font.bold: true
			width: scaleItemWidth(189)
			height: scaleItemHeight(26)
			horizontalAlignment : Text.AlignHCenter
			verticalAlignment : Text.AlignVCenter
		}
				
		Image{
			id: ratingstars
			anchors.top: parent.top
			anchors.topMargin: scaleItemHeight (30)
			anchors.left: parent.left
			anchors.leftMargin: scaleItemWidth(30)
			width: scaleItemWidth(129)
			height: scaleItemHeight(60)
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
			font.pixelSize: scaleItemHeight(15)
			font.bold: true
			opacity: 0.3
			anchors.top: parent.top
			anchors.topMargin: scaleItemHeight (70)
			anchors.left: parent.left
			width: scaleItemWidth(189)
			height: scaleItemHeight(50)
			horizontalAlignment : Text.AlignHCenter
			verticalAlignment : Text.AlignVCenter
		}
	}
	
	Rectangle {
		id: scrollbuttonsContainer
		anchors.right: parent.right
		anchors.rightMargin: scaleItemWidth(30)		
		anchors.bottom: parent.bottom
		anchors.bottomMargin: scaleItemHeight(30)
		color: colorScheme[theme].background 
		opacity: 0
		
		AnimatedImage {
			anchors.bottom: parent.bottom
			anchors.right: parent.right
			width: scaleItemWidth(80)
			fillMode: Image.PreserveAspectFit
			source: "../assets/images/icons/Colorful_PlatformWheel_Arrows_Vertical_type2.gif"
		}
	}

	Item {
		SortFilterProxyModel {
            id: filteredGames
            sourceModel: currentCollection.games
			sorters: RoleSorter { roleName: "favorite"; sortOrder: Qt.DescendingOrder; enabled: favoritesOnTop; }
            filters: ValueFilter { roleName: "favorite"; value: true; enabled: favoritesFiltered }
        }
		
		SortFilterProxyModel {
            id: allFavoritesFiltered
            sourceModel: api.allGames 
            filters: ValueFilter { roleName: "favorite"; value: true }
        }
		
		SortFilterProxyModel {
            id: lastPlayedFiltered
            sourceModel: api.allGames 
			sorters: RoleSorter { roleName: "lastPlayed"; sortOrder: Qt.DescendingOrder; }
            filters: ValueFilter { roleName: "favorite"; value: true; enabled: favoritesFiltered }
		}
	}

   function findCurrentGameFromProxy(idx, collection) {
        if (collection.shortName == "lastplayed") {
            return api.allGames.get(lastPlayedFiltered.mapToSource(idx));
        } else if (collection.shortName == "favorites") {
            return api.allGames.get(allFavoritesFiltered.mapToSource(idx));
        } else {
            return currentCollection.games.get(filteredGames.mapToSource(idx))
        }
    }	
	
	property int currentGameIndex: 0
    property var currentGame: {
        if (gameAxis.count === 0)
            return null;
        return findCurrentGameFromProxy(currentGameIndex, currentCollection);
    }
	
	Item {															
		id: nogamesContainer
			anchors.left: parent.left
			anchors.top: parent.top
			anchors.topMargin: scaleItemHeight(115)
			anchors.leftMargin: scaleItemWidth(30)
		
			visible: currentGame == null && (gameswheel.state === "filtered")
		
		Text {
			id: nogames
			
			text: "No games available for current filter"
			color: colorScheme[theme].text
			font.family: globalFonts.sans
			font.pixelSize: scaleItemHeight(30)
			font.bold: true
		}
	}
	
	state: {
        if (!favoritesFiltered)
            return "unfiltered"
        else return "filtered"
    }
}
