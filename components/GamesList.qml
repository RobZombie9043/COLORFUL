import QtQuick 2.6
import QtMultimedia 5.15
import QtGraphicalEffects 1.15
import "qrc:/qmlutils" as PegasusUtils
import SortFilterProxyModel 0.2

FocusScope {
    id: gameslist
	
	property var titleContentHeight: gameTitle.contentHeight
	property var rating: (currentGame.rating * 5).toFixed(1)
	property bool playing: false
	property bool favoritesFiltered: false
		
	Rectangle {												
		width: scaleItemWidth(576)   
		height: parent.height
		anchors.top: parent.top
		anchors.right: parent.right
		color: colorScheme[theme].background
	}
	
	Rectangle {												
		width: scaleItemWidth (704)   
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		color: collectiondata.getColor(currentCollection.shortName);
	}
	
	ListView {												
		id: gameListView
		
		model: filteredGames
		delegate: gameListViewDelegate
		
		width: scaleItemWidth(282)
		anchors.left: parent.left
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.topMargin: scaleItemHeight(115)
		anchors.bottomMargin: scaleItemHeight(115)
		anchors.leftMargin: scaleItemWidth(-30)
		
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
				event.accepted = true;
				root.state = 'collections'
				videoPreviewLoader.sourceComponent = undefined;
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
		
		preferredHighlightBegin : height * 0.5 - scaleItemHeight(15)
		preferredHighlightEnd: height * 0.5 + scaleItemHeight(15)
		
		currentIndex: currentGameIndex
        onCurrentIndexChanged: currentGameIndex = currentIndex
		
		highlightRangeMode: ListView.ApplyRange
		highlightMoveDuration: 0
		highlight: highlight
	
		Component {
			id: gameListViewDelegate
			
			Text {
				text: ListView.isCurrentItem ? "\u25BA" + modelData.title : modelData.title  //alternative to add a red heart symbol to listview game title text: ListView.isCurrentItem ? "\u25BA" + (modelData.favorite ? "\u2764 " : "") + modelData.title : (modelData.favorite ? "\u2764 " : "") + modelData.title
				color: ListView.isCurrentItem ? collectiondata.getColor(currentCollection.shortName) : colorScheme[theme].background
				font.family: globalFonts.sans
				font.pixelSize: ListView.isCurrentItem ? scaleItemHeight(20) : scaleItemHeight(15)
				font.bold: true

				width: scaleItemWidth(282) 
				height: scaleItemHeight(31)
				leftPadding: ListView.isCurrentItem ? scaleItemWidth(30) : scaleItemWidth(45)
				verticalAlignment: Text.AlignVCenter
				elide: Text.ElideRight		

				Image {
					id: heart
					anchors.right: parent.right
					anchors.rightMargin: -scaleItemWidth(27)
					anchors.top: parent.top
					anchors.topMargin: scaleItemHeight(3)
					verticalAlignment: Image.AlignVCenter
					source: "../assets/images/icons/Colorful_IconFav.png"
					width: scaleItemWidth(24)
					height: scaleItemHeight(24)
					opacity: modelData.favorite
				}

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
			width: scaleItemWidth(282) 
			height: scaleItemHeight(24)
			color: colorScheme[theme].background
			radius: scaleItemHeight(30)
		}
	}
	
	Item {
		id: gamecovercontainer
		anchors.fill: parent
		visible: currentGame !== null
		
		Image {
			id: gamecover									
			width: scaleItemWidth(392)
			height: parent.height - scaleItemHeight(120)
			fillMode: Image.PreserveAspectFit
			source: currentGame.assets.boxFront
			asynchronous: true

			anchors.left: parent.left
			anchors.leftMargin: scaleItemWidth(282)
			anchors.verticalCenter: parent.verticalCenter
		}
	}
	
	Item {
		id: genreContainer
		width: scaleItemWidth(364)
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(734)
		anchors.bottom: parent.bottom
		anchors.bottomMargin: scaleItemHeight(513) + titleContentHeight + scaleItemHeight(10)
		visible: currentGame !== null
				
		Text {
			id: genre
			text: currentGame.genre
			color: collectiondata.getColor(currentCollection.shortName);
			font {
				pixelSize: scaleItemHeight(18);
				letterSpacing: 1.3;
				bold: true;
			}
			width: parent.width
			anchors.bottom: parent.bottom
			wrapMode: Text.Wrap
			maximumLineCount: titleContentHeight < scaleItemHeight(135) ? 3 : 2
		}
	}
	
	Item {
		id: gametitleContainer
		
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(734)
		anchors.bottom: parent.bottom
		anchors.bottomMargin: scaleItemHeight(513)
		visible: currentGame !== null
				
		Text {
			id: gameTitle
			text: currentGame.title
			color: colorScheme[theme].text 
			font.family: globalFonts.sans
			font.pixelSize: scaleItemHeight(36)
			font.bold: true
			width: scaleItemWidth(364)
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
		anchors.bottomMargin: scaleItemHeight(485)
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(734)
		visible: currentGame !== null
		
		Image {
			id: ratingstars
			
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			width: scaleItemWidth(364)
			height: scaleItemHeight (18)
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
		width: scaleItemWidth(364)
		height: scaleItemHeight (135)
		anchors.bottom: parent.bottom
		anchors.bottomMargin: scaleItemHeight(330)
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(734)
		visible: currentGame !== null
		
		PegasusUtils.AutoScroll {												
            id: scrollArea
			anchors.fill: parent
			Text {
				id: gameSummary
				text: currentGame.description
				color: colorScheme[theme].text
				opacity: 0.6;
				font {
					pixelSize: scaleItemHeight(16);
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
		
		width: scaleItemWidth(516)
		height: scaleItemHeight (270)
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(734)		
		anchors.bottom: parent.bottom
		anchors.bottomMargin: scaleItemHeight(40)
		visible: currentGame !== null
		
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
					
		width: scaleItemWidth(516)
		height: scaleItemHeight (270)
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(734)		
		anchors.bottom: parent.bottom
		anchors.bottomMargin: scaleItemHeight(40)
		visible: currentGame !== null
	
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
			if (currentGame && videoSource && videoplaygames && root.state === 'gameslist')
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
		id: favoriteiconContainer
		
		width: scaleItemWidth(30)
		height: scaleItemHeight(30)
		anchors.left: parent.left
		anchors.leftMargin: scaleItemWidth(1128)
		anchors.bottom: parent.bottom
		anchors.bottomMargin: scaleItemHeight(520)
	
		Image {
			id: favoriteicon
			
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			verticalAlignment : Image.AlignBottom
			width: scaleItemWidth(30)
			height: scaleItemHeight(30)
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
		id: gameYearContainer
			width: scaleItemWidth (137)
			anchors.left: parent.left
			anchors.leftMargin: scaleItemWidth(1128)	
			anchors.bottom: parent.bottom
			anchors.bottomMargin: scaleItemHeight(485)
			visible: currentGame !== null
		
		Text {
			id: gameYear
			
			text: currentGame.releaseYear ? currentGame.releaseYear : ""
			color: collectiondata.getColor(currentCollection.shortName)
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			font.family: globalFonts.sans
			font.pixelSize: scaleItemHeight(18)
			font.bold: true
		}
	}
	
	Item {															
		id: gameinfoContainer
			width: scaleItemWidth (137)
			anchors.left: parent.left
			anchors.leftMargin: scaleItemWidth(1128)	
			anchors.top: parent.top
			anchors.topMargin: scaleItemHeight(255)
			visible: currentGame !== null
		
		Text {
			id: gamePlayers
			
			text: playerCountText(currentGame.players)
			color: colorScheme[theme].text
			anchors.top: parent.top
			anchors.left: parent.left
			font.family: globalFonts.sans
			font.pixelSize: scaleItemHeight(18)
			font.bold: false
			opacity: 0.6
		}
		
		Text {
			id: developer
			
			text: currentGame.developer
			color: colorScheme[theme].text
			anchors.top: gamePlayers.bottom
			anchors.topMargin: scaleItemHeight(10)
			anchors.left: parent.left
			font.family: globalFonts.sans
			font.pixelSize: scaleItemHeight(18)
			font.bold: false
			width: scaleItemWidth(142)
			wrapMode: Text.Wrap
			opacity: 0.6
		}
	}
	
	function playerCountText(count) {
        return count === 1 ? "1 Player" : count + " Players";
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
        if (gameListView.count === 0) 
            return null;
		return findCurrentGameFromProxy(currentGameIndex, currentCollection);
	}
	
	Item {															
		id: nogamesContainer
			anchors.left: parent.left
			anchors.top: parent.top
			anchors.topMargin: scaleItemHeight(115)
			anchors.leftMargin: scaleItemWidth(30)
		
			visible: currentGame == null && (gameslist.state === "filtered")
		
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