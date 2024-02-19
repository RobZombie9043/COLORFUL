import QtQuick 2.0
import QtMultimedia 5.15
import "components"
import SortFilterProxyModel 0.2


FocusScope {
    id: root

	property int currentCollectionIndex: 0
    property string state: 'collections' 

    Collections{
        id: collections
		width: root.width
        height: root.height
        focus: (root.state === 'collections')
        opacity: focus
        visible: opacity
    }

    GamesWheel{
        id: gameswheel
		width: root.width
        height: root.height
        focus: (root.state === 'gameswheel')
        opacity: focus
        visible: opacity
    }
	
	GamesList{
        id: gameslist
		width: root.width
        height: root.height
        focus: (root.state === 'gameslist')
        opacity: focus
        visible: opacity
    }
	
	CollectionData{
        id: collectiondata
 	}
	
	Settings{
        id: settings
		width: root.width
        height: root.height
        focus: (root.state === 'settings')
        opacity: focus
        visible: opacity
    }

    property var colorScheme: {
		"Dark": {
            background: "#25283B",
            text: "white",
            accent: "#757BA0",
        },
         "Light": {
            background: "white",
            text: "black",
            accent: "#10AEBE",
        },
        "Ozone Dark": {
            background: "#2D2D2D",
            text: "white",
            accent: "#00D9AE",
        },
        "Steam OS": {
            background: "#2B2F38",
            text: "white",
            accent: "#1A9FFF",
        },
		"Black": {
            background: "black",
            text: "white",
            accent: "gray",
        },
		"Dark Gray": {
            background: "#222",
            text: "white",
            accent: "orange",
        }
    }
	
	property string gamesview: {
        if (api.memory.get('gamesview') == "List") {
            return "gameslist";
        } else {
            return "gameswheel";
        }
    }
	
	property string theme: {
        if (api.memory.get('themeIndex') == "1") {
            return "Light";
        } else if (api.memory.get('themeIndex') == "2") {
            return "Ozone Dark";
        } else if (api.memory.get('themeIndex') == "3") {
            return "Steam OS";
		} else if (api.memory.get('themeIndex') == "4") {
            return "Black";
		} else if (api.memory.get('themeIndex') == "5") {
            return "Dark Gray";
        } else {
            return "Dark";
        }
    }
	
	property string logo: {
        if (api.memory.get('logoIndex') == "1") {
            return "Dark - Black";
		} else if (api.memory.get('logoIndex') == "2") {
            return "Light - Color";
		} else if (api.memory.get('logoIndex') == "3") {
            return "Light - White";
        } else {
            return "Dark - Color";
        }
    }
	
	property string buttons: {
        if (api.memory.get('buttonsIndex') == "1") {
            return "../assets/images/icons/Colorful_PlatformWheel1_ButtonStart_B.png";
		} else if (api.memory.get('buttonsIndex') == "2") {
            return "../assets/images/icons/Colorful_PlatformWheel1_ButtonStart_X.png";
		} else if (api.memory.get('buttonsIndex') == "3") {
            return "../assets/images/icons/Colorful_PlatformWheel1_ButtonStart_O.png";
        } else {
            return "../assets/images/icons/Colorful_PlatformWheel1_ButtonStart_A.png";
        }
    }
	
	property bool videosound: {
        if (api.memory.get('videosound') == "Disabled") {
            return true;
        } else {
            return false
		}
	}
	
	property bool videoplaycollections: {
        if (api.memory.get('videoplaycollections') == "Enabled") {
            return true;
        } else {
            return false
		}
	}
	
	property bool videoplaygames: {
        if (api.memory.get('videoplaygames') == "Enabled") {
            return true;
        } else {
            return false
		}
	}

	property int allGamesCollection: api.memory.get('allGamesCollectionIndex') || 0
    property int favoritesCollection: api.memory.get('favoritesCollectionIndex') || 0
    property int lastPlayedCollection: api.memory.get('lastPlayedCollectionIndex') || 0
	
	property var allCollections: {
        var collections = api.collections.toVarArray()
        if (favoritesCollection !== 1) {
            collections.unshift({"name": "Favorites", "shortName": "favorites", "games": allFavorites });
        }
        if (lastPlayedCollection !== 1) {
            collections.unshift({"name": "Last Played", "shortName": "lastplayed", "games": lastPlayed });
        }
        if (allGamesCollection !== 1) {
            collections.unshift({"name": "All Games", "shortName": "allgames", "games": api.allGames });
        }
        return collections
    }
	
	property var currentCollection: allCollections[currentCollectionIndex]
	
	SortFilterProxyModel {
        id: allFavorites
        sourceModel: api.allGames
        filters: ValueFilter { roleName: "favorite"; value: true; }
    }

    SortFilterProxyModel {
        id: lastPlayedBase
        sourceModel: api.allGames
        sorters: RoleSorter { roleName: "lastPlayed"; sortOrder: Qt.DescendingOrder; }
    }

    SortFilterProxyModel {
        id: lastPlayed
        sourceModel: lastPlayedBase
        filters: IndexFilter { maximumIndex: 49; }
    }
	
	property int screenwidth: Screen.width
	property int screenheight: Screen.height
	property real scaleFactor: Math.min(width / 1280, height / 720)
	
	function scaleItem(originalSize) {
		return originalSize * scaleFactor
    }
}

