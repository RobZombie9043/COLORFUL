import QtQuick 2.0
import QtMultimedia 5.15
import "components"

FocusScope {
    id: root

    property int currentCollectionIndex: 0
    property var currentCollection: api.collections.get(currentCollectionIndex)
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
        "OzoneDark": {
            background: "#2D2D2D",
            text: "white",
            accent: "#00D9AE",
        },
        "SteamOS": {
            background: "#2B2F38",
            text: "white",
            accent: "#1A9FFF",
        },
		"Black": {
            background: "black",
            text: "white",
            accent: "gray",
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
            return "OzoneDark";
        } else if (api.memory.get('themeIndex') == "3") {
            return "SteamOS";
		} else if (api.memory.get('themeIndex') == "4") {
            return "Black";
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
        if (api.memory.get('buttons') == "PlayStation") {
            return "../assets/images/icons/Colorful_PlatformWheel1_ButtonStart_PS.png"
        } else {
            return "../assets/images/icons/Colorful_PlatformWheel1_ButtonStart_XBox.png"
        }
    }
	
	property bool videosound: {
        if (api.memory.get('videosound') == "Disabled") {
            return true;
        } else {
            return false
		}
	}
}

