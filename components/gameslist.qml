import QtQuick 2.6
import QtMultimedia 5.15
import QtGraphicalEffects 1.15
import "qrc:/qmlutils" as PegasusUtils

FocusScope {
    id: gameslist
	
	property var currentGame: currentCollection.games.get(gameListView.currentIndex)
	property var titleContentHeight: gameTitle.contentHeight
	property var rating: (currentGame.rating * 5).toFixed(1)
	property string state: root.state
	property bool playing: false
	
	Rectangle {												
		width: vpx(576)   
		height: parent.height
		anchors.top: parent.top
		anchors.right: parent.right
		color: colorScheme[theme].background
	}
	
	Rectangle {												
		width: vpx (704)   
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		color: collectiondata.getColor(currentCollection.shortName);
	}
	
	ListView {												
		id: gameListView
		
		model: currentCollection.games
		delegate: gameListViewDelegate
		
		width: vpx(282)
		anchors.left: parent.left
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.topMargin: vpx(115)
		anchors.bottomMargin: vpx(115)
		anchors.leftMargin: vpx(-30)
		
		focus:true
		
		keyNavigationWraps: true		
		Keys.onPressed:{
			if (api.keys.isAccept(event))
			{
				event.accepted = true;
				currentGame.launch()
			}
			if (api.keys.isCancel(event))
			{
				event.accepted = true;
				root.state = 'collections'
			}
			if (api.keys.isDetails(event))
			{
				event.accepted = true;
				root.state = 'settings'
			}
			if (api.keys.isFilters(event)) 
			{
				event.accepted = true;
				currentGame.favorite = !currentGame.favorite;
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
		
		preferredHighlightBegin : height * 0.5 - vpx(15)
		preferredHighlightEnd: height * 0.5 + vpx(15)
		
		highlightRangeMode: ListView.ApplyRange
		highlightMoveDuration: 0
		highlight: highlight
	
		Component {
			id: gameListViewDelegate

			Text {
				text: ListView.isCurrentItem ? "\u25BA" + modelData.title : modelData.title
				color: ListView.isCurrentItem ? collectiondata.getColor(currentCollection.shortName) : colorScheme[theme].background //"white"
				font.family: globalFonts.sans
				font.pixelSize: ListView.isCurrentItem ? vpx(20) : vpx(15)
				font.bold: true

				width: ListView.isCurrentItem ? vpx(282) : vpx(252) 
				height: ListView.isCurrentItem ? vpx(31) : vpx(29)
				leftPadding: ListView.isCurrentItem ? vpx(30) : vpx(45)
				verticalAlignment: Text.AlignVCenter
				elide: Text.ElideRight

				MouseArea {											
					anchors.fill: parent
					onClicked: {
						gameListView.currentIndex = index; 		
					}
				}
			}
		}
	}
	
	Component {
		id: highlight
		Rectangle {
			width: vpx(282) 
			height: vpx(24)
			color: colorScheme[theme].background
			radius: vpx(30)
		}
	}
	
	Item {
		id: gamecovercontainer
		anchors.fill: parent
		
		Image {
			id: gamecover									
			width: vpx(392)
			height: parent.height - vpx(120)
			fillMode: Image.PreserveAspectFit
			source: currentGame.assets.boxFront
			asynchronous: true

			anchors.left: parent.left
			anchors.leftMargin: vpx(282)
			anchors.verticalCenter: parent.verticalCenter
		}
		
		Image {
			id: favoriteicon
			width: vpx(30)
			height: vpx(30)
			anchors.left: gamecover.left
			anchors.leftMargin: gamecover.width/2
			anchors.bottom: parent.bottom 
			anchors.bottomMargin: (vpx(720) - gamecover.paintedHeight)/2 - vpx (40)
			opacity: currentGame.favorite
			source: "../assets/images/icons/Colorful_IconFav.png"
		}
		
		ColorOverlay {
			anchors.fill: favoriteicon
			source: favoriteicon
			color: colorScheme[theme].text
			opacity: currentGame.favorite
		}
	}
	
	Item {
		id: genreContainer
		width: vpx(364)
		anchors.left: parent.left
		anchors.leftMargin: vpx(734)
		anchors.bottom: parent.bottom
		anchors.bottomMargin: vpx(513) + titleContentHeight + vpx(10)
				
		Text {
			id: genre
			text: currentGame.genre
			color: collectiondata.getColor(currentCollection.shortName);
			font {
				pixelSize: vpx(18);
				letterSpacing: 1.3;
				bold: true;
			}
			width: parent.width
			anchors.bottom: parent.bottom
			wrapMode: Text.Wrap
			maximumLineCount: titleContentHeight < vpx(135) ? 3 : 2
		}
	}
	
	Item {
		id: gametitleContainer
		
		anchors.left: parent.left
		anchors.leftMargin: vpx(734)
		anchors.bottom: parent.bottom
		anchors.bottomMargin: vpx(513)
				
		Text {
			id: gameTitle
			text: currentGame.title
			color: colorScheme[theme].text 
			font.family: globalFonts.sans
			font.pixelSize: vpx(36)
			font.bold: true
			width: vpx(364)
			maximumLineCount: 3
			elide: Text.ElideRight
			wrapMode: Text.Wrap
			verticalAlignment : Text.AlignBottom
			anchors.bottom: parent.bottom
			clip: true
		}
	}
	
	Item {
		id: ratingstarscontainer
		anchors.bottom: parent.bottom
		anchors.bottomMargin: vpx(485)
		anchors.left: parent.left
		anchors.leftMargin: vpx(734)
		
		Image {
			id: ratingstars
			
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			width: vpx(364)
			height: vpx (18)
			horizontalAlignment : Image.AlignLeft
			fillMode: Image.PreserveAspectFit
			source: "../assets/images/stars/" + rating + ".png"
		}
		
		ColorOverlay {
			anchors.fill: ratingstars
			source: ratingstars
			color: colorScheme[theme].text
		}
	}
	
	Item {
		id: gamesummaryContainer
		width: vpx(364)
		height: vpx (135)
		anchors.bottom: parent.bottom
		anchors.bottomMargin: vpx(330)
		anchors.left: parent.left
		anchors.leftMargin: vpx(734)
		
		PegasusUtils.AutoScroll {												
            id: scrollArea
			anchors.fill: parent
			Text {
				id: gameSummary
				text: currentGame.description
				color: colorScheme[theme].text
				opacity: 0.6;
				font {
					pixelSize: vpx(16);
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
		id: gamescreenshotcontainer
		
		width: vpx(516)
		height: vpx (270)
		anchors.left: parent.left
		anchors.leftMargin: vpx(734)		
		anchors.bottom: parent.bottom
		anchors.bottomMargin: vpx(40)
		
		Image {
			id: gamescreenshot
			
			anchors.fill: parent
			horizontalAlignment : Image.AlignLeft
			fillMode: Image.PreserveAspectFit
			source: currentGame.assets.screenshot
			opacity: 1
		}
	}
	
	Item {
		id: videocontainer
					
		width: vpx(516)
		height: vpx (270)
		anchors.left: parent.left
		anchors.leftMargin: vpx(734)		
		anchors.bottom: parent.bottom
		anchors.bottomMargin: vpx(40)
	
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
		transitions.state = "screenshotloaded";
	}

	onPlayingChanged: {
		videoPreviewLoader.sourceComponent = undefined;
		videoDelay.restart();
		scrollArea.restartScroll();
		transitions.state = "screenshotloaded";
	}

	onStateChanged: {
		videoPreviewLoader.sourceComponent = undefined;
		videoDelay.restart();
		scrollArea.restartScroll();
		transitions.state = "screenshotloaded";
	}

	property string videoSource: currentGame.assets.video
	
	Timer {
		id: videoDelay

		interval: 1000
		onTriggered: {
			if (currentGame && videoSource && root.state === 'gameslist')
			{
				videoPreviewLoader.sourceComponent = videoPreviewWrapper;
				transitions.state = "videoloaded";
			}
		}
	}

	Component {
		id: videoPreviewWrapper

		Video {
			id: videocomponent
			
			property var aspectratio: metaData.resolution.width / metaData.resolution.height
			
			width: parent.height * aspectratio
			height: parent.height
			anchors.left: parent.left
			anchors.bottom: parent.bottom
			
			source: videoSource ?? ""
			fillMode: VideoOutput.PreserveAspectFit
			loops: MediaPlayer.Infinite
			autoPlay: true
			visible: videoSource
			muted: videosound
		}
	}

	Item {
		id: transitions
	
		transitions: [
			Transition {
				to: "videoloaded"
				NumberAnimation { target: gamescreenshot; property: "opacity"; to: 0 ; duration: 250 }
			},
			Transition {
				to: "screenshotloaded"
				NumberAnimation { target: gamescreenshot; property: "opacity"; to: 1 ; duration: 0 }
			}
		]
	}
	
	Item {														
		id: gameYearContainer
			width: vpx (137)
			anchors.left: parent.left
			anchors.leftMargin: vpx(1128)	
			anchors.bottom: parent.bottom
			anchors.bottomMargin: vpx(485)
		
		Text {
			id: gameYear
			
			text: currentGame.releaseYear ? currentGame.releaseYear : ""
			color: collectiondata.getColor(currentCollection.shortName)
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			font.family: globalFonts.sans
			font.pixelSize: vpx(18)
			font.bold: true
		}
	}
	
	Item {															
		id: gameinfoContainer
			width: vpx (137)
			anchors.left: parent.left
			anchors.leftMargin: vpx(1128)	
			anchors.top: parent.top
			anchors.topMargin: vpx(255)
		
		Text {
			id: gamePlayers
			
			text: playerCountText(currentGame.players)
			color: colorScheme[theme].text
			anchors.top: parent.top
			anchors.left: parent.left
			font.family: globalFonts.sans
			font.pixelSize: vpx(18)
			font.bold: false
			opacity: 0.6
		}
		
		Text {
			id: developer
			
			text: currentGame.developer
			color: colorScheme[theme].text
			anchors.top: gamePlayers.bottom
			anchors.topMargin: vpx(10)
			anchors.left: parent.left
			font.family: globalFonts.sans
			font.pixelSize: vpx(18)
			font.bold: false
			width: vpx(142)
			wrapMode: Text.Wrap
			opacity: 0.6
		}
	}
	
	function playerCountText(count) {
        return count === 1 ? "1 Player" : count + " Players";
    }
}