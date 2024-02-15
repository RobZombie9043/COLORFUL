# COLORFUL

---
A port of the COLORFUL bigbox theme to Pegasus.

[![Video](.meta/screenshots/CollectionsWheel.png)](https://youtu.be/O1Q5IVHPxeI)
![CollectionDetails](.meta/screenshots/CollectionsDetails.png)
![GameListView](.meta/screenshots/GamesListView.png)

---

Video assets for the Collections pages **are required** to be downloaded separately (due to the size) or else there will only be static images. 

1080P versions for many platforms (60+), renamed for this theme are available as a separate zip with the release (~1gb) or can be [downloaded individually here](https://mega.nz/folder/6VByEKTS#I7yela1-PrAzneLCQkw1jg).
Additional platforms can be found at the [creators page](https://forums.launchbox-app.com/files/file/1958-colorful-platform-video-set/).

Collections must be named using the shortnames listed below (or some common variations) to work properly - these can be checked in the collectiondata.qml if videos and images are not loading for collections.

Platforms included:
3do, 3ds, amiga, android, arcade, atari2600, atari5200, atari7800, atarijaguar, atarilynx, atomiswave, c64, cdi, colecovision, cps1, cps2, cps3, dos, dreamcast, famicom, fbneo, fds, gamecube, gamegear, gb, gba, gbc, genesis, gw, intellivision, mame, mastersystem, msx, mvs, n64, naomi, nds, neogeo, neogeocd, nes, ngp, ngpc, odyssey2, pcecd, pcengine, pico8, pokemini, ps2, psp, psx, saturn, scummvm, sega32x, segacd, sfc, sg1000, snes, supergrafx, switch, tg16, tgcd, vboy, vectrex, vita, wii, wswan, wswanc, x68000, zxspectrum

---

## Metadata used in the theme:
- `boxFront`
- `screenshot`
- `wheel`
- `video`

---

## Changelog:
- 0.10 Initial release
- 0.11 Added device images and fallback for when no collection videos exist, fixed loading of game screenshots in game wheel view when no game video exists
- 0.12 Updated collections video and image sources to check against common platform shortname aliases to be less dependant on following exact naming convention, added Accept button options for A, B, cross (X) and circle (O) covering Xbox/Nintendo/PS layouts and regional variations, updated theme settings shortcut key to 'Details' button (i.e. xbox Y, PS triangle)

This has only been tested on an AYN Odin 2 but reach out if anything is not working as expected, you have suggestions or would like any other systems added!

---

## To Do:
- [x] Fall back images for no collection video
- [x] Add shortname alias function for image/video source references 
- [x] Mark as favorite button
- [x] Add favorite icons to game views
- [ ] Touch controls
- [ ] All/Favorites/Recents collections
- [x] Shortcut keys to change collection index from game view
- [ ] Shortcut keys to move to start/end of list / skip letter
- [ ] Nav sounds
- [ ] Better color matching between videos and rendered text/shapes
- [ ] Favorites filter
- [ ] Favorites on top toggle
- [ ] Fix game auto scroll on first transition to list view
- [ ] Return to previous screen when closing settings

---

## Credits:
- viking - creator of the [COLORFUL media set and theme](https://forums.launchbox-app.com/files/file/2081-colorful-bigbox-theme/)
- Dan Patrick - [v2 Platform Logos](https://forums.launchbox-app.com/files/file/3402-v2-platform-logos-professionally-redrawn-official-versions-new-bigbox-defaults/page/2/?tab=comments#comment-12469)
- All the Pegasus theme creators that I have borrowed ideas from especially [epic-memories-theme](https://github.com/FrenchGithubUser/epic-memories-theme), [retromega-sleipnir](https://github.com/y-muller/retromega-sleipnir) and [shinretro](https://github.com/TigraTT-Driver/shinretro)
