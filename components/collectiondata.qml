import QtQuick 2.15

Item {
    function getColor(shortName) {
        const alias = getAlias(shortName);
        return collectiondata.metadata[alias].color
            ?? collectiondata.metadata['default'].color;
    }

    function getVendorYear(shortName) {
        const alias = getAlias(shortName);
        const vendor = collectiondata.metadata[alias].vendor ?? '';
        const year = collectiondata.metadata[alias].year ?? '';

        return [vendor, year]
            .filter(v => { return v !== '' })
            .join(' • ');
    }
	
	function getYear(shortName) {
        const alias = getAlias(shortName);
		return collectiondata.metadata[alias].year ?? '';
	}
	
	function getSummary(shortName) {
        const alias = getAlias(shortName);
        return collectiondata.metadata[alias].summary ?? '';
	}

    function getImage(shortName) {
        const alias = getAlias(shortName);
        if (alias === 'default') return shortName;
        return collectiondata.metadata[alias].image ?? alias;
    }

    function getAlias(shortName) {
        if (aliases[shortName] !== undefined) return aliases[shortName];
        if (metadata[shortName] !== undefined) return shortName;
        return 'default'
    }

    property var aliases: {
        '3do interactive multiplayer': '3do',
		'panasonic 3do': '3do',
		'panasonic 3do interactive multiplayer': '3do',
		'nintendo 3ds': '3ds',
        'commodore amiga': 'amiga',
		'androidapps': 'android',
		'androidemulators': 'android',
		'androidgames': 'android',
		'droid': 'android',
		'fba': 'arcade',
        'fbn': 'arcade',
		'fbneo': 'arcade',
		'mame': 'arcade',
		'final burn alpha': 'arcade',
        'final burn neo': 'arcade',
		'atari 2600': 'atari2600',
        '2600': 'atari2600',
		'atari': 'atari2600',
        'atari 5200': 'atari5200',
        '5200': 'atari5200',
		'Atari 5200 SuperSystem': 'atari5200',
		'5200 SuperSystem': 'atari5200',
		'Atari SuperSystem': 'atari5200',
		'SuperSystem': 'atari5200',
		'atari 7800': 'atari7800',
        '7800': 'atari7800',
		'atari7800 ProSystem': 'atari7800',
		'7800 ProSystem': 'atari7800',
		'atari ProSystem': 'atari7800',
		'ProSystem': 'atari7800',
		'atari jaguar': 'atarijaguar',
        'jaguar': 'atarijaguar',
        'atari lynx': 'atarilynx',
		'lynx': 'atarilynx',
		'sammy atomiswave': 'atomiswave',
		'commodore 64': 'c64',
        'cd-i': 'cdi',
		'Philips CD-i': 'cdi',
		'Philips CD-i (Compact Disc Interactive)': 'cdi',
		'Compact Disc Interactive': 'cdi',
		'Philips Compact Disc Interactive': 'cdi',
		'Philips': 'cdi',
		'Philips CD-i': 'cdi',
		'coleco': 'colecovision',
		'coleco vision': 'colecovision',
		'capcom cps1': 'cps1',
        'capcom cps2': 'cps2',
        'capcom cps3': 'cps3',
		'msdos': 'dos',
		'ms-dos': 'dos',
		'microsoft ms-dos': 'dos',
		'microsoft dos': 'dos',
		'dc': 'dreamcast',
		'sega dreamcast': 'dreamcast',
		'nintendo famicom disk system': 'fds',
		'famicom disk system': 'fds',
		'gc': 'gamecube',
		'nintendo gamecube': 'gamecube',
		'ngc': 'gamecube',
		'game cube': 'gamecube',
		'gcn': 'gamecube',
		'sega game gear': 'gamegear',
		'game gear': 'gamegear',
		'gameboy': 'gb',
		'nintendo game boy': 'gb',
		'nintendo super game boy': 'gb',
		'super game boy': 'gb',
		'super gameboy': 'gb',
		'nintendo super gameboy': 'gb',
		'game boy': 'gb',
		'ngb': 'gb',
		'nintendo gameboy': 'gb',
		'nintendo gb': 'gb',
		'gameboyadvance': 'gba',
		'nintendo game boy advance': 'gba',
		'Game Boy Advance': 'gba',
		'GameBoy Advance': 'gba',
		'nintendo gameboy advance': 'gba',
		'nintendo gba': 'gba',
		'gameboycolor': 'gbc',
		'game boy color': 'gbc',
		'nintendo game boy color': 'gbc',
		'gameboy color': 'gbc',
		'nintendo gameboy color': 'gbc',
		// 'md': 'genesis',						
        // 'megadrive': 'genesis',					
		// 'mega drive': 'genesis',
		// 'sega megadrive': 'genesis',
		// 'sega mega drive': 'genesis',			
		'sega genesis': 'genesis',   
        'Genesis/Mega Drive': 'genesis',   
        'gameandwatch': 'gw',
        'gamewatch': 'gw',
		'nintendo game and watch': 'gw',
		'mattel intellivision': 'intellivision',
		'sms': 'mastersystem',
		'sega master system': 'mastersystem',
		'master system': 'mastersystem',
		'md': 'megadrive',
		'sega megadrive': 'megadrive',
		'sega mega drive': 'megadrive',
		'msx2': 'msx',
        'msx2+': 'msx',
		'microsoft msx': 'msx',
        'microsoft msx2': 'msx',
		'msx 2': 'msx',
		'msx 2+': 'msx',
		'msx laserdisc': 'msx',
		'Neo Geo MVS': 'mvs',
		'SNK Neo-Geo MVS': 'mvs',
		'snk neo geo mvs': 'mvs',
		'nintendo 64': 'n64',
		'nintendo n64': 'n64',
		'sega naomi': 'naomi',
		'nintendo ds': 'nds',
		'nintendo dsi': 'nds',
		'ndsi': 'nds',
		'dsi': 'nds',
		'ds': 'nds',
		'aes': 'neogeo',
        'neogeoaes': 'neogeo',
		'snk neo geo aes': 'neogeo',
		'neo geo': 'neogeo',
		'Neo Geo Advanced Entertainment System': 'neogeo',
		'neo geo aes': 'neogeo',
		'neogeo aes': 'neogeo',
		'NeoGeo Advanced Entertainment System': 'neogeo',
		'snk neogeo aes': 'neogeo',
		'snk neogeo': 'neogeo',
		'snk neo geo cd': 'neogeocd',
		'snk neo-geo cd': 'neogeocd',
		'neo-geo cd': 'neogeocd',
        'neogeo cd': 'neogeocd',
		'neo geo cd': 'neogeocd',
		'snk neogeo cd': 'neogeocd',
		'ngcd': 'neogeocd',
		'fc': 'nes',
		'nintendo entertainment system': 'nes',
		'nintendo': 'nes',
		'famicom': 'nes',
        'nintendo nes': 'nes',
		'nintendo entertainment system (nes)': 'nes',
		'nes/famicom': 'nes',
		'snk neo geo pocket': 'ngp',
		'neogeo pocket': 'ngp',
		'neo geo pocket': 'ngp',
		'snk neo-geo pocket': 'ngp',
		'snk neo geo pocket color': 'ngpc',
		'neogeo pocket color': 'ngpc',
		'neo geo pocket color': 'ngpc',
		'snk neo-geo pocket color': 'ngpc',
		'neo geo pocket color': 'ngpc',
		'neogeo color': 'ngpc',
		'Magnavox Odyssey 2': 'odyssey2',
		'Odyssey 2': 'odyssey2',
		'pcenginecd': 'pcecd',
		'pc engine cd': 'pcecd',
		'nec pc engine cd': 'pcecd',
		'pce': 'pcengine',
		'pc engine': 'pcengine',
		'nec pc engine': 'pcengine',
		'pico-8': 'pico8',
		'sony playstation 2': 'ps2',
		'playstation 2': 'ps2',
		'play station 2': 'ps2',
		'sony play station 2': 'ps2',
        'sony psp': 'psp',
		'sony playstation portable': 'psp',
        'playstation portable': 'psp',
		'ps1': 'psx',
		'sony playstation': 'psx',
		'playstation': 'psx',
		'play station': 'psx',
		'sony play station': 'psx',
		'ps': 'psx',
		'sony ps1': 'psx',
		'sony psx': 'psx',
		'sony ps': 'psx',
		'sega saturn': 'saturn',
		'mega32x': 'sega32x',
		'sega 32x': 'sega32x',
		'32x': 'sega32x',
		'sega cd': 'segacd',
        'megacd': 'segacd',
		'sg-1000': 'sg1000',
		'sega sg-1000': 'sg1000',
		'sega game 1000': 'sg1000',
		'sega sg1000': 'sg1000', 
		'superfamicom': 'snes',
        'superfc': 'snes',
        'supernes': 'snes',
        'super nintendo entertainment system': 'snes',
		'super nintendo': 'snes',
		'super nes': 'snes',
		'super famicom': 'snes',
		'sfc': 'snes',
		'pc engine supergrafx': 'supergrafx',
        'nec supergrafx': 'supergrafx',
		'turbografx16': 'tg16',
		'nec turbografx-16': 'tg16',
		'tg16cd': 'tgcd',
        'turbografx16cd': 'tgcd',
        'vb': 'vboy',
        'virtualboy': 'vboy',
		'gce vectrex': 'vectrex',
		'ps vita': 'vita',
		'sony ps vita': 'vita',
		'sony playstation vita': 'vita',
		'playstation vita': 'vita',
		'psvita': 'vita',
		'nintendo wii': 'wii',
        'wonderswan': 'wswan',
		'wonder swan': 'wswan',
        'wonderswanc': 'wswanc',
        'wonderswancolor': 'wswanc',
        'x68k': 'x68000',
		'sinclair zx spectrum': 'zxspectrum',
              
    }

    property var metadata: {
        '3do': { color: '#d0a73f', vendor: 'The 3DO Company', year: '1993', summary: 'The 3DO Interactive Multiplayer (often called simply 3DO) is a video game console originally produced by Panasonic in 1993. Further renditions of the hardware were released in 1994 by Sanyo and Goldstar. The consoles were manufactured according to specifications created by The 3DO Company, and were originally designed by Dave Needle and RJ Mical of New Technology Group. The system was conceived by entrepreneur and Electronic Arts founder Trip Hawkins.' },
		
        '3ds': { color: '#697583', vendor: 'Nintendo', year: '2011', summary: 'The Nintendo 3DS, abbreviated to 3DS, is a portable game console produced by Nintendo. It is capable of displaying stereoscopic 3D effects without the use of 3D glasses or additional accessories. Nintendo announced the device in March 2010 and officially unveiled it at E3 2010 on June 15, 2010. The console succeeds the Nintendo DS, featuring backward compatibility with older Nintendo DS and Nintendo DSi video games.' },
        'allgames': { color: '#292463' },
		
        'amiga': { color: '#3870c5', vendor: 'Commodore', year: '1985', summary: 'The Amiga is a family of personal computers marketed by Commodore in the 1980s and 1990s. The first model was launched in 1985 as a high-end home computer and became popular for its graphical, audio and multi-tasking abilities. The Amiga provided a significant upgrade from 8-bit computers, such as the Commodore 64, and the platform quickly grew in popularity among computer enthusiasts. The best selling model, the Amiga 500, was introduced in 1987 and became the leading home computer of the late 1980s and early 1990s in much of Western Europe' },
        
		'android': { color: '#2ec781', vendor: 'Google', year: '2008', summary: 'Android is a mobile operating system (OS) based on the Linux kernel and currently developed by Google. With a user interface based on direct manipulation, Android is designed primarily for touchscreen mobile devices such as smartphones and tablet computers, with specialized user interfaces for televisions (Android TV), cars (Android Auto), and wrist watches (Android Wear). The OS uses touch inputs that loosely correspond to real-world actions, like swiping, tapping, pinching, and reverse pinching to manipulate on-screen objects, and a virtual keyboard. Despite being primarily designed for touchscreen input, it has also been used in game consoles, digital cameras, regular PCs, and other electronics. As of 2015, Android has the largest installed base of all operating systems.' },
        
		'arcade': { color: '#5D60B9', vendor: 'Various', year: '1971', summary: 'An arcade game or coin-op is a coin-operated entertainment machine typically installed in public businesses such as restaurants, bars and amusement arcades. Most arcade games are video games, pinball machines, electro-mechanical games, redemption games or merchandisers. While exact dates are debated, the golden age of arcade video games is usually defined as a period beginning sometime in the late 1970s and ending sometime in the mid-1980s. Excluding a brief resurgence in the early 1990s, the arcade industry subsequently declined in the Western hemisphere as competing home-based video game consoles such as Playstation and Xbox increased in their graphics and game-play capability and decreased in cost.' },
        
		'atari2600': { color: '#b92e35', vendor: 'Atari', year: '1977', summary: 'The Atari Video Computer System (VCS), later named the Atari 2600, is a second generation (1976–1992) home video game console developed and distributed by Atari, Inc. It was released on September 11, 1977 in North America at a retail price of $199. The console was later released in Europe (1978) and Japan (1983 - as the Atari 2800). The Atari 2600 popularized the use of microprocessor-based hardware and games contained on ROM cartridges. The console was discontinued on January 1, 1992. Rereleased as the Atari 2600+. This item is currently available from Atari for pre-order and will ship in December 2023.' },
        
		'atari5200': { color: '#40599c', vendor: 'Atari', year: '1982', summary: 'The Atari 5200 SuperSystem, commonly known as the Atari 5200, is a second generation (1976–1992) video game console developed and distributed by Atari, Inc. It was released in November 1982 in North America at a retail price of $269. It was not released outside North America. The 5200s internal hardware was almost identical to Ataris 8-bit computers however it came with an innovative controller featuring a 360-degree non-centering joystick with a numeric keypad, start, pause, and reset buttons. The console was discontinued on May 21, 1984.' },
        
		'atari7800': { color: '#2f7bc7', vendor: 'Atari', year: '1986', summary: 'The Atari 7800 Pro System, commonly known as the Atari 7800, is a third generation (1983-2003) video game console developed and distributed by Atari Corporation. It was released in May 1986 in North America at a retail price of $79.95. The console was later released in Europe (1987). The 7800 is considered one of the first backward-compatible consoles as it could play Atari 2600 games without the use of additional modules. The console was discontinued on January 1, 1992.' },
        
		'atarijaguar': { color: '#cf3d3e', vendor: 'Atari', year: '1993', summary: 'The Atari Jaguar is a fifth generation (1993–2005) video game console developed and distributed by Atari Corporation. It was released in November 1993 in North America at a retail price of $249.99. The console was later released in Europe (1994), Australia (1994), and Japan (1994). The Jaguar was marketed as being the first 64-bit video game console; however this claim was widely criticized.  The console was discontinued in early 1996, possibly at the time of the companys sale on April 8, 1996.' },
        
		'atarilynx': { color: '#e49838', vendor: 'Atari', year: '1989', summary: 'The Atari Lynx, usually just referred to as Lynx, is a fourth generation (1987-2004) handheld video game console developed in partnership with Epyx, Inc. and distributed by the Atari Corporation. It was released in September 1989 in North America at a retail price of $149.95. The handheld was also released in Europe (1990) and Japan (1990). The Lynx was the worlds first handheld electronic game with a color LCD screen. The console was discontinued in early 1996, possibly at the time of the companys sale on April 8, 1996.' },
       
		'atomiswave': { color: '#30ae6e', vendor: 'Sammy', year: '2003', summary: 'The Atomiswave is a custom arcade system board and cabinet from Sammy Corporation. It is based on Segas NAOMI system board (thus its common to see the "Sega" logo on its boot up screen). The Atomiswave uses interchangeable game cartridges and the cabinets control panel can be easily switched out with different control sets, including dual joysticks, dual lightguns and a steering wheel.	With the retirement of the aging Neo Geo MVS system, SNK Playmore chose the Atomiswave as its next system to develop games for. In a contract with Sammy, SNK Playmore agreed to develop five games for the Atomiswave system. Metal Slug 6 was SNK Playmores fifth game for the Atomiswave, after which SNK moved on to a Taito Type X2 arcade board.' },
       
		'c64': { color: '#0959b2', vendor: 'Commodore', year: '1982', summary: 'The Commodore 64 is an 8-bit home computer introduced in January 1982 by Commodore International. It is listed in the Guinness World Records as the highest-selling single computer model of all time, with independent estimates placing the number sold between 10 and 17 million units. Volume production started in early 1982, marketing in August for US$595 (equivalent to $1,461 in 2015). Preceded by the Commodore VIC-20 and Commodore PET, the C64 took its name from its 64 kilobytes (65,536 bytes) of RAM. It had superior sound and graphical specifications compared to other earlier systems such as the Apple II and Atari 800, with multi-color sprites and a more advanced sound processor.' },
    
		'cdi': { color: '#c171a4', vendor: 'Philips', year: '1990', summary: 'The Philips CD-i (Compact Disc Interactive) is an interactive multimedia CD player developed and marketed by Royal Philips Electronics N.V. This category of device was created to provide more functionality than an audio CD player or game console, but at a lower price than a personal computer with CD-ROM drive at the time. The cost savings were due to the lack of a hard drive, floppy drive, keyboard, mouse, monitor (a standard television was used), and less operating system software. In addition to games, educational and multimedia reference titles were produced, such as interactive encyclopedias, museum tours, etc. before public Internet access was widespread. Competitors included the Tandy VIS and Commodore CDTV. Seen as a game console, the CD-i format proved to be a commercial failure. The company lost nearly one billion dollars on the entire project. The failure of the CD-i caused Philips to leave the video game industry after it was discontinued. The CD-i is also one of the earliest consoles to implement internet features, including subscriptions, web browsing, downloading, e-mail, and online play. This was facilitated by the use of an additional hardware modem that Philips released in 1996.' },
		
		'colecovision': { color: '#de5b3f', vendor: 'Coleco', year: '1982', summary: 'The ColecoVision is a second generation (1976–1992) home video game console developed and distributed by Coleco Industries. It was released in August 1982 in North America at a retail price of $175. The console was later released in Europe (1983). The ColecoVision offered a closer experience to arcade games than its competitors at the time. The console was discontinued in mid-1985.' },
      
		'cps1': { color: '#025836', vendor: 'Capcom', year: '1988', summary: 'The CP System (CPS for short and retroactively known as CPS-1) is an arcade system board developed by Capcom that ran game software stored on removable daughterboards. More than two dozen arcade titles were released for CPS-1, before Capcom shifted game development over to its successor, the CP System II. Among the 33 titles released for the original CP System include Street Fighter II: The World Warrior and its first two follow-ups, Street Fighter II: Champion Edition and Street Fighter II: Hyper Fighting.' },
        
		'cps2': { color: '#049728', vendor: 'Capcom', year: '1993', summary: 'The CP System II or CPS-2 is an arcade system board that Capcom first used in 1993 for Super Street Fighter II. It was the successor to their previous CP System and Capcom Power System Changer arcade hardware and was succeeded by the CP System III hardware in 1996, of which the CPS-2 would outlive by over four years. The arcade system had new releases for it until the end of 2003, ending with Hyper Street Fighter II.' },
        
		'cps3': { color: '#258ed1', vendor: 'Capcom', year: '1996', summary: 'The CP System III or CPS-3 is an arcade system board that was first used by Capcom in 1996 with the arcade game Red Earth. It was the second successor to the CP System arcade hardware, following the CP System II. It would be the last proprietary system board Capcom would produce before moving on to the Dreamcast-based Naomi platform.' },
        
		'default': { color: '#194492' },
        
		'dos': { color: '#2d62c1', vendor: 'Microsoft', year: '1981', summary: 'MS-DOS, short for Microsoft Disk Operating System, was an operating system for x86-based personal computers mostly developed by Microsoft. It was the most commonly used member of the DOS family of operating systems, and was the main operating system for IBM PC compatible personal computers during the 1980s to the mid-1990s, when it was gradually superseded by operating systems offering a graphical user interface (GUI), in various generations of the Microsoft Windows operating system.' },
        
		'dreamcast': { color: '#4d7dd7', vendor: 'Sega', year: '1998', summary: 'The Dreamcast is a 128-bit video game console which was released by Sega in late 1998 in Japan and from September 1999 in other territories. It was the first entry in the sixth generation of video game consoles, preceding Sonys PlayStation 2, Microsofts Xbox and the Nintendo GameCube.' },
        
		'favorites': { color: '#82cdea' },
        
		'fds': { color: '#191a49', vendor: 'Nintendo', year: '1986', summary: 'The Family Computer Disk System, sometimes shortened as the Famicom Disk System or simply the Disk System, and abbreviated as the FDS or FCD, is a peripheral for Nintendos Family Computer home video game console, released in Japan on February 21, 1986. It uses proprietary floppy disks called "Disk Cards" for data storage. Through its entire production span, 1986–2003, 4.44 million units were sold.  The device is connected to the Famicom deck by plugging a special cartridge known as the RAM Adapter into the systems cartridge port, and attaching that cartridges cable to the disk drive. The RAM adapter contains 32 kilobytes (KB) of RAM for temporary program storage, 8 KB of RAM for tile and sprite data storage, and an ASIC known as the 2C33. The ASIC acts as a disk controller for the floppy drive, and also includes additional sound hardware featuring a single-cycle wavetable-lookup synthesizer. Finally, embedded in the 2C33 is an 8KB BIOS ROM. The Disk Cards used are double-sided, with a total capacity of 112 KB per disk. Many games span both sides of a disk, requiring the user to switch sides at some point during gameplay. A few games use two full disks, totaling four sides. The Disk System is capable of running on six C-cell batteries or the supplied AC adapter. Batteries usually last five months with daily game play. The battery option is due to the likelihood of a standard set of AC plugs already being occupied by a Famicom and a television.'},
        
		'gamecube': { color: '#9682f0', vendor: 'Nintendo', year: '2001', summary: 'The Nintendo GameCube was the first Nintendo console to use optical discs as its primary storage medium. In contrast with the GameCubes contemporary competitors, Sonys PlayStation 2, Segas Dreamcast and Microsofts Xbox, the GameCube uses mini DVD-based discs instead of full-size DVDs. Partially as a result of this, it does not have the DVD-Video playback functionality of these systems, nor the audio CD playback ability of other consoles that use full-size optical discs.' },
        
		'gamegear': { color: '#366fb1', vendor: 'Sega', year: '1990', summary: 'The Sega Game Gear was Segas first handheld game console. It was the third commercially available color handheld console, after the Atari Lynx and the TurboExpress. Work began on the console in 1989 under the codename "Project Mercury", following Segas policy at the time of codenaming their systems after planets. The system was released in Japan on October 6, 1990, North America, Europe and Argentina in 1991, and Australia in 1992. The launch price was $150 US and £145 UK. Sega dropped support for the Game Gear in early 1997.' },
        
		'gb': { color: '#414f8b', vendor: 'Nintendo', year: '1989', summary: 'The Game Boy is an 8-bit handheld video game console developed and manufactured by Nintendo. It was released in Japan on April 21, 1989, in North America in August 1989, and in Europe in 1990. In Southern Asia, it is known as the "Tata Game Boy" It is the first handheld console in the Game Boy line. It was created by Gunpei Yokoi and Nintendos Research and Development — the same staff who had designed the Game &amp; Watch series as well as several popular games for the NES.  The Game Boy was Nintendos second handheld system following the Game &amp; Watch series introduced in 1980, and it combined features from both the Nintendo Entertainment System and Game and Watch. It was also the first handheld game to use video game cartridges since Milton Bradleys Microvision handheld console. It was originally bundled with the puzzle game Tetris.  Despite many other, technologically superior handheld consoles introduced during its lifetime, the Game Boy was a tremendous success. The Game Boy and Game Boy Color combined have sold 118.69 million units worldwide. Upon its release in the United States, it sold its entire shipment of one million units within weeks.' },
        
		'gba': { color: '#4e73d7', vendor: 'Nintendo', year: '2001', summary: 'The Game Boy Advance (abbreviated as GBA) is a 32-bit handheld video game console developed, manufactured and marketed by Nintendo as the successor to the Game Boy Color. It was released in Japan on March 21, 2001, in North America on June 11, 2001, in Australia and Europe on June 22, 2001, and in mainland China on June 8, 2004 (iQue Player). Nintendos competitors in the handheld market at the time were the Neo Geo Pocket Color, WonderSwan, GP32, Tapwave Zodiac, and the N-Gage. Despite the competitors best efforts, Nintendo maintained a majority market share with the Game Boy Advance.  As of June 30, 2010, the Game Boy Advance series has sold 81.51 million units worldwide. Its successor, the Nintendo DS, was released in November 2004 and is also compatible with Game Boy Advance software.' },
        
		'gbc': { color: '#f5b72c', vendor: 'Nintendo', year: '1998', summary: 'The Game Boy Color, (abbreviated as GBC) is a handheld game console manufactured by Nintendo, which was released on October 21, 1998 in Japan and was released in November of the same year in international markets. It is the successor of the Game Boy.  The Game Boy Color, as suggested by the name, features a color screen, but no backlight. It is slightly thicker and taller than the Game Boy Pocket, which is a redesigned Game Boy released in 1996. As with the original Game Boy, it has a custom 8-bit processor somewhat related to a Zilog Z80 central processing unit (CPU). The original name - with its American English spelling of "color" - remained unchanged even in markets where "colour" was the accepted English spelling.  The Game Boy Colors primary competitors were the much more advanced Neo Geo Pocket by SNK and the WonderSwan by Bandai (both released in Japan only), though the Game Boy Color outsold these by a wide margin. The Game Boy and Game Boy Color combined have sold 118.69 million units worldwide. It was discontinued in 2003, shortly after the release of the Game Boy Advance SP.' },
        
		'genesis': { color: '#c23b2c', vendor: 'Sega', year: '1988', summary: 'The Sega Genesis, known as the Mega Drive in most regions outside North America, is a 16-bit home video game console which was developed and sold by Sega Enterprises, Ltd. The Genesis was Segas third console and the successor to the Master System. Sega first released the console as the Mega Drive in Japan in 1988, followed by a North American debut under the Genesis moniker in 1989. In 1990, the console was distributed as the Mega Drive by Virgin Mastertronic in Europe, by Ozisoft in Australasia, and by Tec Toy in Brazil. In South Korea, the systems were distributed by Samsung and were known as the Super Gam*Boy, and later the Super Aladdin Boy. The main microprocessor of the Genesis is a 16/32-bit Motorola 68000 CPU clocked at 7.6 MHz. The console also includes a Zilog Z80 sub-processor, which was mainly used to control the sound hardware and also provides backwards compatibility with the Master System.' },
        
		'gw': { color: '#8ea5ae', vendor: 'Nintendo', year: '1980', summary: 'The Game & Watch series are a total of 60 handheld electronic games produced by Nintendo from 1980 to 1991. Created by game designer Gunpei Yokoi, each Game & Watch features a single game to be played on an LCD screen in addition to a clock, an alarm, or both. This console inspired Nintendo to make the Game Boy. It was the earliest Nintendo product to gain major success.' },
        
		'intellivision': { color: '#f28311', vendor: 'Mattel', year: '1979', summary: 'The Mattel Intellivision is a second generation (1976–1992) home video game console developed and distributed by Mattel Electronics. It was released in summer 1979 in North America at a retail price of $299. The console was later released in Europe (1981), South America (1982), and Japan (1982). The Intellivision was the first home console to use a tile based playfield and was the first game console to provide real-time human voices in the middle of gameplay, courtesy of the IntelliVoice module. The console was discontinued in early-1990.' },
        
		'mastersystem': { color: '#c2403e', vendor: 'Sega', year: '1985', summary: 'The Master System (abbreviated to SMS) is a third-generation video game console that was manufactured and released by Sega in 1985 in Japan (as the Sega Mark III), 1986 in North America and 1987 in Europe. The original SMS could play both cartridges and the credit card-sized "Sega Cards," which retailed for cheaper prices than cartridges but had less code. The SMS also featured accessories such as a light gun and 3D glasses which were designed to work with a range of specially coded games. The Master System was released as a direct competitor to the Nintendo Entertainment System in the third videogame generation The SMS was technically superior to the NES, which predated its release significantly, but failed to overturn Nintendos significant market share advantage in Japan and North America.' },
        
		'megadrive': { color: '#0e7acd', vendor: 'Sega', year: '1988', summary: 'The Sega Genesis, known as the Mega Drive in most regions outside North America, is a 16-bit home video game console which was developed and sold by Sega Enterprises, Ltd. The Genesis was Segas third console and the successor to the Master System. Sega first released the console as the Mega Drive in Japan in 1988, followed by a North American debut under the Genesis moniker in 1989. In 1990, the console was distributed as the Mega Drive by Virgin Mastertronic in Europe, by Ozisoft in Australasia, and by Tec Toy in Brazil. In South Korea, the systems were distributed by Samsung and were known as the Super Gam*Boy, and later the Super Aladdin Boy. The main microprocessor of the Genesis is a 16/32-bit Motorola 68000 CPU clocked at 7.6 MHz. The console also includes a Zilog Z80 sub-processor, which was mainly used to control the sound hardware and also provides backwards compatibility with the Master System.' },
		
		'msx': { color: '#32a8ec', vendor: 'Microsoft', year: '1983', summary: 'MSX is the name of a standardized home computer architecture, first announced by Microsoft on June 16, 1983. Before the appearance and great success of Nintendos Family Computer, MSX was the platform for which major Japanese game studios, such as Konami and Hudson Soft, produced video game titles. The Metal Gear series, for example, was originally written for MSX hardware.' },
        
		'mvs': { color: '#d64444', vendor: 'SNK', year: '1990', summary: 'The Neo Geo, stylised as NEO·GEO, also written as NEOGEO, is a cartridge-based arcade system board and fourth-generation home video game console released on April 26, 1990, by Japanese game company SNK Corporation. It was the first system in SNKs Neo Geo family. The Neo Geo was marketed as 24-bit; its CPU is technically a parallel processing 16/32-bit 68000-based system with an 8/16-bit Z80 coprocessor much like the Sega Genesis, while its GPU chipset has a 24-bit graphics data bus.  The Neo Geo originally launched as the MVS (Multi Video System) coin-operated arcade machine. The MVS offers owners the ability to put up to six different cartridges into a single cabinet, a unique feature that was also a key economic consideration for operators with limited floorspace, as well as saving money in the long-run. With its games stored on self-contained cartridges, a game cabinet can be exchanged for a different game title by swapping the games ROM Cartridge and cabinet artwork. A home console version was also made, called AES (Advanced Entertainment System). It was originally launched as a rental console for video game stores in Japan (called Neo Geo Rental System), with its high price causing SNK not to release it for home use – this was later reversed due to high demand and it came into the market as a luxury console. The AES had the same raw specs as the MVS and had full compatibility, thus managed to bring a true arcade experience to home users. As of 2013 it was the most expensive home video game console ever released, costing US$1,125 adjusted for inflation. The Neo Geo was revived along with the brand overall in December 2012 through the introduction of the Neo Geo X handheld and home system.'},
        
		'n64': { color: '#1bb861', vendor: 'Nintendo', year: '1996', summary: 'Named for its 64-bit central processing unit, it was released in June 1996 in Japan, September 1996 in North America, March 1997 in Europe and Australia, September 1997 in France and December 1997 in Brazil. As part of the fifth generation of gaming, the N64 competed primarily with the PlayStation and the Sega Saturn. The Nintendo 64 was launched with three games: Super Mario 64 and Pilotwings 64, released worldwide; and Saikyo Habu Shogi, released only in Japan. While the N64 was succeeded by Nintendos MiniDVD-based GameCube in November 2001, N64 consoles remained available until the system was retired in late 2003.' },
        
		'naomi': { color: '#ef8310', vendor: 'Sega', year: '1998', summary: 'The Sega NAOMI (New Arcade Operation Machine Idea) is an arcade system board released in 1998 as a successor to Sega Model 3 hardware. It uses the same architecture as the Sega Dreamcast, and stands as one of Segas most successful arcade systems of all time, along with the Sega Model 2. The NAOMI debuted at a time when traditional arcades were on a decline, and so was engineered to be a mass-produced, cost-effective machine reliant on large game ROM "cartridges" which could be interchanged by the arcade operator. This is contrary to systems such as the Model 3, in which each board, despite sharing largely the same specifications, would be bespoke, with the built-in ROMs being flashed with games during the manufacturing process. This is not the first time such an idea was utilised by Sega, but never before had technology been used for a cutting-edge Sega arcade specification. Unlike most hardware platforms in the arcade industry, NAOMI was widely licensed for use by other manufacturers, many of which were former rivals to Sega such as Taito, Capcom and Namco. It is also one of the longest-serving arcade boards, being supported from 1998 to 2009. It is a platform where many top-rated Sega franchises were born, including Virtua Tennis, Samba de Amigo, Crazy Taxi and Monkey Ball. The NAOMI was succeeded by the Sega Hikaru and Sega NAOMI 2 boards, though having out-lasted the NAOMI 2, Hikaru and Sega Aurora. The Sega Chihiro, or possibly even the Sega Lindbergh, could also be seen as successors.' },
        
		'nds': { color: '#b6c9d6', vendor: 'Nintendo', year: '2004', summary: 'The Nintendo DS or simply, DS, is a 32-bit dual-screen handheld game console developed and released by Nintendo. The device went on sale in North America on November 21, 2004. The DS, short for "Developers System" or "Dual Screen", introduced distinctive new features to handheld gaming: two LCD screens working in tandem (the bottom one featuring a touchscreen), a built-in microphone, and support for wireless connectivity. Both screens are encompassed within a clamshell design similar to the Game Boy Advance SP. The Nintendo DS also features the ability for multiple DS consoles to directly interact with each other over Wi-Fi within a short range without the need to connect to an existing wireless network. Alternatively, they could interact online using the now-closed Nintendo Wi-Fi Connection service.' },
        
		'neogeo': { color: '#7c828c', vendor: 'SNK', year: '1990', summary: 'The Advanced Entertainment System (AES), originally known just as the Neo Geo, is the first video game console in the family. The hardware features comparatively colorful 2D graphics. The hardware was in part designed by Alpha Denshi (later ADK).  Initially, the home system was only available for rent to commercial establishments, such as hotel chains, bars and restaurants, and other venues. When customer response indicated that some gamers were willing to buy a US$650 console, SNK expanded sales and marketing into the home console market. The Neo Geo console was officially launched on 31 January 1990 in Osaka, Japan. The AES is identical to its arcade counterpart, the MVS, so arcade games released for the home market are nearly identical conversions.' },
        
		'neogeocd': { color: '#af98e6', vendor: 'SNK', year: '1994', summary: 'The Neo Geo CD, released in 1994, was initially an upgrade from the original AES. This console uses CDs instead of ROM cartridges like the AES. The units (approximately) 1X CD-ROM drive was slow, making loading times very long with the system loading up to 56 Mbits of data between loads. Neo Geo CD game prices were low at US$50, in contrast to Neo Geo AES game cartridges which cost as much as US$300. The system could also play Audio CDs. All three versions of the system have no region-lock.  The Neo Geo CD was bundled with a control pad instead of a joystick like the AES. However, the original AES joystick can be used with all 3 Neo Geo CD models (top loader, front loader and CDZ, an upgraded version of the CD console, that was only released in Japan), instead of the included control pads.'},
        
		'nes': { color: '#ba3141', vendor: 'Nintendo', year: '1983', summary: 'The Nintendo Entertainment System is an 8-bit video game console that was released by Nintendo in North America during 1985, in Europe during 1986 and Australia in 1987. In most of Asia, including Japan (where it was first launched in 1983), China, Vietnam, Singapore, the Middle East and Hong Kong, it was released as the Family Computer, commonly shortened as either the romanized contraction Famicom, or abbreviated to FC. In South Korea, it was known as the Hyundai Comboy, and was distributed by Hynix which then was known as Hyundai Electronics.' },
        
		'ngp': { color: '#ed9f46', vendor: 'SNK', year: '1998', summary: 'The Neo Geo Pocket is a monochrome handheld game console released by SNK. It was the companys first handheld system and is part of the Neo Geo family. It debuted in Japan in late 1998 but never saw a western release, being exclusive to Japan and smaller Asian markets such as Hong Kong.  The Neo Geo Pocket is considered to be an unsuccessful console. Lower than expected sales resulted in its discontinuation in 1999, and was immediately succeeded by the Neo Geo Pocket Color, a full color device allowing the system to compete more easily with the dominant Game Boy Color handheld, and which also saw a western release. Though the system enjoyed only a short life, there were some significant games released on the system such as Samurai Shodown, and King of Fighters R-1.' },
        
		'ngpc': { color: '#ed9f46', vendor: 'SNK', year: '1999', summary: 'The Neo Geo Pocket Color (also stylized as NEOGEOPOCKET COLOR, often abbreviated NGPC), is a 16-bit color handheld video game console manufactured by SNK. It is a successor to SNKs monochrome Neo Geo Pocket handheld which debuted in 1998 in Japan, with the Color being fully backward compatible. The Neo Geo Pocket Color was released on March 16, 1999 in Japan, August 6, 1999 in North America, and on October 1, 1999 in Europe, entering markets all dominated by Nintendo.  After a good sales start in both the U.S. and Japan with 14 launch titles (a record at the time) subsequent low retail support in the U.S., lack of communication with third-party developers by SNKs American management, the craze about Nintendos Pokémon franchise, anticipation of the 32-bit Game Boy Advance, as well as strong competition from Bandais WonderSwan in Japan, led to a sales decline in both regions.  Meanwhile, SNK had been in financial trouble for at least a year; the company soon collapsed, and was purchased by American pachinko manufacturer Aruze in January 2000. However, Aruze didnt support SNKs video game business enough, leading to SNKs original founder and several other employees to leave and form a new company, BrezzaSoft. Eventually on June 13, 2000, Aruze decided to quit the North American and European markets, marking the end of SNKs worldwide operations and the discontinuation of Neo Geo hardware and software there. The Neo Geo Pocket Color (and other SNK/Neo Geo products) did however, last until 2001 in Japan. It was SNKs last video game console, as the company went bankrupt on October 22, 2001.  Despite its failure the Neo Geo Pocket Color has been regarded as an influential system. Many highly acclaimed games were released for the system, such as SNK vs. Capcom: The Match of the Millennium, King of Fighters R-2, and other quality arcade titles derived from SNKs MVS and AES. It also featured an arcade-style microswitched "clicky stick" joystick, which was praised for its accuracy and being well-suited for fighting games. The systems display and 40-hour battery life were also well received.' },
        
		'odyssey2': { color: '#f08211', vendor: 'Magnavox', year: '1978', summary: 'The Magnavox Odyssey 2 is a second generation (1976–1992) home video game console developed and distributed by Magnavox. It was released in February 1979 in North America at a retail price of $179. The console was also released in Europe (1979), and later South America (1983), and Japan (1982). The Odyssey 2 included a full alphanumeric membrane keyboard, which was to be used for educational games, selecting options, or programming. The console was discontinued on March 20, 1984.' },
        
		'pcecd': { color: '#598dca', vendor: 'NEC', year: '1988', summary: 'The TurboGrafx-CD is an add on for the TurboGrafx-16. It was released to expand the library of games of the TurboGrafx 16.' },
        
		'pcengine': { color: '#bd3e43', vendor: 'NEC', year: '1987', summary: 'TurboGrafx-16, fully titled as TurboGrafx-16 Entertainment SuperSystem and known in Japan as the PC Engine, is a video game console developed by Hudson Soft and NEC, released in Japan on October 30, 1987, and in North America on August 29, 1989.' },
        
		'pico8': { color: '#1c542d', vendor: 'Lexaloffle', year: '2015', summary: 'PICO-8 is a fantasy console for making, sharing and playing tiny games and other computer programs. When you turn it on, the machine greets you with a shell for typing in Lua programs and provides simple built-in tools for creating sprites, maps and sound.' },
        
		'pokemini': { color: '#405189', vendor: 'Nintendo', year: '2001', summary: 'The Pokémon Mini is a handheld game console that was designed and manufactured by Nintendo and themed around the Pokémon media franchise. It is the smallest game system with interchangeable cartridges ever produced by Nintendo, weighing just under two and a half ounces (70 grams). It was first released in North America on November 16, 2001, then in Japan on December 14, 2001, and in Europe on March 15, 2002. The systems were released in three colors: Wooper Blue, Chikorita Green, and Smoochum Purple.  Features of the Pokémon mini include an internal real-time clock, an infrared port used to facilitate multiplayer gaming, a reed switch for detecting shakes, and a motor used to implement force feedback. The GameCube game Pokémon Channel features playable demo versions of several Pokémon mini games via console emulation. Also included in the game is Snorlaxs Lunch Time, a Pokémon Channel exclusive. Some games were only released in Japan, such as Togepis Adventure.' },
        
		'ports': { color: '#1d334a' },
        
		'ps2': { color: '#3069c0', vendor: 'Sony', year: '2000', summary: 'The Sony PlayStation 2, or PS2 for short, is a sixth generation (1998–2013) home video game console developed and distributed by Sony Interactive Entertainment. It was released on March 4, 2000 in Japan at a retail price of ¥45,000. The console was later released in North America (2000), Europe (2000), and Australia (2000). The PlayStation 2 was the first PlayStation console to offer backwards compatibility for its predecessors DualShock controller, as well as for its games. The console was discontinued on January 4, 2013.' },
        
		'psp': { color: '#376da9', vendor: 'Sony', year: '2004', summary: 'The PlayStation Portable (PSP) is a handheld game console developed by Sony. Development of the handheld was announced during E3 2003, and it was unveiled on May 11, 2004, at a Sony press conference before E3 2004. The system was released in Japan on December 12, 2004, in North America on March 24, 2005, and in the PAL region on September 1, 2005. It primarily competed with the Nintendo DS, as part of the seventh generation of video games.  The PlayStation Portable became the most powerful portable system when launched, just after the Nintendo DS in 2004. It was the first real competitor to Nintendos handheld domination, where many challengers, such as SNKs Neo Geo Pocket and Nokias N-Gage, failed. Its GPU encompassed high-end graphics on a handheld, while its 4.3 inch viewing screen and multi-media capabilities, such as its video player and TV tuner, made the PlayStation Portable a major mobile entertainment device at the time. It also features connectivity with the PlayStation 3, other PSPs and the Internet. It is the only handheld console to use an optical disc format, Universal Media Disc (UMD), as its primary storage medium.  The original PSP model (PSP-1000) was replaced by a slimmer model with design changes (PSP-2000/"Slim & Lite") in 2007. Another remodeling followed in 2008, PSP-3000, which included a new screen and an inbuilt microphone. A complete redesign, PSP Go, came in 2009, followed by a budget model, PSP-E1000, in 2011. The PSP line was succeeded by the PlayStation Vita, released in December 2011 in Japan, and in February 2012 worldwide. The PlayStation Vita features backward compatibility with many PlayStation Portable games digitally released on the PlayStation Network, via PlayStation Store. Shipments of the PlayStation Portable ended throughout 2014 worldwide, having sold 80 million units in its 10-year lifetime.' },
        
		'psx': { color: '#878c92', vendor: 'Sony', year: '1994', summary: 'The Sony PlayStation, or PS for short, is a fifth generation (1993–2005) home video game console developed and distributed by Sony Interactive Entertainment. It was released on December 3, 1994 in Japan at a retail price of ¥37,000. The console was later released in North America (1995), Europe (1995), Australia (1995), and Korea (1996). The PlayStation was known for standardizing disc based games over cartridges, as well as controllers with two analog sticks and vibration feedback.  The console was discontinued on March 23, 2006.' },
        
		'recents': { color: '#906226', vendor: 'past 30 days' },
        
		'saturn': { color: '#5b7ada', vendor: 'Sega', year: '1994', summary: 'The Sega Saturn is a 32-bit fifth-generation video game console that was first released by Sega on November 22, 1994 in Japan, May 11, 1995 in North America, and July 8, 1995 in Europe. The system was discontinued in North America and Europe in 1998, and in 2000 in Japan. While it was popular in Japan, the Saturn failed to gain a similar market share in North America and Europe against its main competitors: Sonys PlayStation and the Nintendo 64.' },
        
		'scummvm': { color: '#f09514', vendor: 'Lucasfilm Games', year: '1987', summary: 'Script Creation Utility for Maniac Mansion Virtual Machine (ScummVM) is a set of game engine recreations. Originally designed to play LucasArts adventure games that use the SCUMM system, it also supports a variety of non-SCUMM games by companies like Revolution Software and Adventure Soft. It was originally written by Ludvig Strigeus. Released under the terms of the GNU General Public License, ScummVM is free software.  ScummVM is a reimplementation of the part of the software used to interpret the scripting languages such games used to describe the game world rather than emulating the hardware the games ran on; as such, ScummVM allows the games it supports to be played on platforms other than those for which they were originally released.' },
        
		'sega32x': { color: '#0e7acd', vendor: 'Sega', year: '1994', summary: 'The Sega Mega Drive console received two add-on hardware upgrades during its life time: the Sega Mega-CD and Sega 32X. It is possible to install both of these on the same base console, creating a system called the Sega Mega-CD 32X (PAL region) or Sega CD 32X (USA). This opens the possibility of software that can utilise both the Mega-CDs enhanced storage capacity and ability to play Red Book CD audio, and the 32Xs enhancements in graphics and sound capabilities.  Six games were released that require both add-on units in order to be played. All of these titles are full motion video based games, which were previously available as standalone Mega-CD games, and later had their FMV assets upgraded to take advantage of the 32Xs improved graphics. As such, all six were released on CDs, with the cart slot of the 32X being unused during gameplay.  Japan did not receive any Mega-CD 32X games, however North America received five while Europe recieved four of those five. Surgical Strike, once bound for a North American release, ended up being an exclusive title in Brazil (and curiously wound up being the only Mega-CD 32X game to reach this region). A further half-dozen titles were in development for the Mega-CD 32X at one stage, but were all cancelled, some merely appearing in Mega-CD form and some being moved to the Sega Saturn.' },
        
		'segacd': { color: '#0e7acd', vendor: 'Sega', year: '1991', summary: 'The Sega CD, released as the Mega-CD in most regions outside North America, is a CD-ROM accessory for the Sega Genesis video game console designed and produced by Sega as part of the fourth generation of video game consoles. The add-on was released on December 12, 1991 in Japan, October 15, 1992 in North America, and 1993 in Europe. The Sega CD lets the user play CD-based games and adds extra hardware functionality, such as a faster central processing unit and graphic enhancements. It can also play audio CDs and CD+G discs.Seeking to create an add-on device for the Genesis, Sega developed the unit to read compact discs as its storage medium. The main benefit of CD technology was greater storage capacity, which allowed for games to be nearly 320 times larger than their Genesis cartridge counterparts. This benefit manifested in the form of full motion video (FMV) games like the controversial Night Trap, which became a focus of the 1993 Congressional hearings on issues of video game violence and ratings. Sega of Japan partnered with JVC to design the add-on and refused to consult with Sega of America until the project was completed. Sega of America assembled parts from various "dummy" units to obtain a working prototype. While the add-on became known for several well-received games such as Sonic the Hedgehog CD and Lunar: Eternal Blue, its game library contained a large number of Genesis ports and FMV titles. The Sega CD was redesigned a number of times, including once by Sega and several times by licensed third-party developers.By the end of 1994, the add-on had sold approximately 2.7 million units worldwide, compared to 29 million units for the Genesis sold by that time. In 1995, Sega began shifting its focus towards its new console, the Sega Saturn, over the Genesis and Sega CD. The Sega CD was officially discontinued in 1996. Retrospective reception to the add-on is mixed, praising the Sega CD for its individual offerings and additions to the Genesis functions, but offering criticism to the game library for its depth issues, high price of the unit, and how the add-on was supported by Sega.' },
          
		'sg1000': { color: '#0c8427', vendor: 'Sega', year: '1983', summary: 'Segas SG-1000 (Sega Game 1000) (a.k.a Mark I) was the companys first attempt at home consoles.  It was initially test marketed in 1981 and finally released to Japanese consumers in July of 1983.  It was a pretty advanced system for its time and featured impressive technical specifications.  The system would be sold in Japan until 1985 and was released in various markets throughout European and Australasia. In 1984, Sega released an updated version of the console called the SG-1000 Mark II.  This remodeled version used gamepads instead of the original joysticks and had mounts to store them on each side.  It also featured a slot which allowed a keyboard attachment called SK-1100 and was compatible with software from the Sega SC-3000 computer.  Sega also sold an optional adaptor called Card Catcher.  This adaptor would allow the SG-1000 to play Sega "Game Card" software.' },
        
		'snes': { color: '#d64042', vendor: 'Nintendo', year: '1990', summary: 'The Super Nintendo Entertainment System (also known as the Super NES, SNES or Super Nintendo, as well as the Super Famicom in Japan) is a 16-bit home video game console developed by Nintendo that was released in 1990 in Japan, 1991 in North America, 1992 in Europe and Australasia (Oceania), and 1993 in South America.In Japan, the system is called the Super Famicom, officially adopting the abbreviated name of its predecessor, the Family Computer, or SFC for short.In South Korea, it is known as the Super Comboy and was distributed by Hyundai Electronics.Although each version is essentially the same, several forms of regional lockout prevent the different versions from being compatible with one another.' },
        
		'supergrafx': { color: '#69b5dc', vendor: 'NEC', year: '1989', summary: 'The PC Engine SuperGrafx, also shortened as the SuperGrafx or PC Engine SG, is a video game console by NEC Home Electronics, released exclusively in Japan. It is an upgraded version of the PC Engine, released two years prior. Like the PC Engine, the SuperGrafx was also imported and sold in France.  Originally announced as the PC Engine 2, the machine was purported to be a true 16-bit system with improved graphics and audio capabilities over the original PC Engine. Expected to be released in 1990, the SuperGrafx was rushed to market, debuting several months earlier in late 1989 with only modest improvements over the original PC Engine.  Only seven games were produced which took advantage of the improved SuperGrafx hardware, and two of those could be played on a regular PC Engine. However, the SuperGrafx is backwards compatible with all PC Engine software in both, HuCard and CD-ROM format, bringing the compatible software total up to nearly 700. The system was not widely adopted and is largely seen as a commercial failure.' },
        
		'switch': { color: '#fb584f', vendor: 'Nintendo', year: '2017', summary: 'The Nintendo Switch is an eighth generation (2012-present) home video game console developed and distributed by Nintendo. It was released on March 3, 2017 in North America at a retail price of $299.99. The console was simultaneously released in Japan (2017), Europe (2017), South America (2017), Australia (2017) and other World Wide Markets (2017). The Switch is designed to be a hybrid console, allowing games to be played at a TV, and then on the go by undocking the system and playing from the handheld unit itself. As of this date, the console is still in production.' },
        
		'tg16': { color: '#f3994d', vendor: 'NEC', year: '1987', summary: 'TurboGrafx-16, fully titled as TurboGrafx-16 Entertainment SuperSystem and known in Japan as the PC Engine, is a video game console developed by Hudson Soft and NEC, released in Japan on October 30, 1987, and in North America on August 29, 1989.' },
        
		'tgcd': { color: '#340f7a', vendor: 'NEC', year: '1988', summary: 'The TurboGrafx-CD is an add on for the TurboGrafx-16. It was released to expand the library of games of the TurboGrafx 16.' },
        
		'vboy': { color: '#e3414c', vendor: 'Nintendo', year: '1995', summary: 'The Virtual Boy is a 32-bit table-top video game console developed and manufactured by Nintendo. Released in 1995, it was marketed as the first console capable of displaying stereoscopic 3D. The player uses the console in a manner similar to a head-mounted display, placing their head against the eyepiece to see a red monochrome display. The games use a parallax effect to create the illusion of depth. Sales failed to meet targets, and by early 1996, Nintendo ceased distribution and game development after shipping 1.26 million units and releasing 22 games.  Development of the Virtual Boy lasted four years, and began originally under the project name of VR32. Nintendo entered a licensing agreement to utilize a 3D LED eyepiece technology originally developed by U.S.-based company Reflection Technology. It also built a factory in China to be used exclusively for Virtual Boy manufacturing. Over the course of development, the console technology was down-scaled due to high costs and potential health concerns. Furthermore, an increasing amount of company resources were being re-allocated to Nintendo 64 development. Lead Nintendo game designer, Shigeru Miyamoto, had little involvement with the Virtual Boy software. The console was pushed to market in an unfinished state in 1995 to focus on Nintendo 64 development.  The Virtual Boy was panned by critics and was a commercial failure. Its failure has been cited as due to its high price, monochrome display, unimpressive 3D effect, lack of true portability, health concerns, and low quality games. Its negative reception was unaffected by continued price drops. 3D technology in video game consoles re-emerged in later years to more success, including in Nintendos own 3DS handheld console. The Virtual Boy is Nintendos second lowest-selling platform after the 64DD.' },
        
		'vectrex': { color: '#4f97d9', vendor: 'Milton Bradley', year: '1982', summary: 'The GCE Vectrex, usually just referred to as Vectrex, is a second generation (1976–1992) home video game console that was developed by Western Technologies/Smith Engineering, and distributed first by General Consumer Electronics (GCE), and later by Milton Bradley Company after its purchase of GCE. It was released in November 1982 in North America at a retail price of $199. The console was later released in Europe (1983) and Japan (1983). The Vectrex had an integrated vector monitor which displayed vector graphics, which set it apart from other consoles that needed a TV to play on. The console discontinued in early 1984.' },
        
		'vita': { color: '#0162c2', vendor: 'Sony', year: '2011', summary: 'TThe PlayStation Vita is a handheld game console manufactured and marketed by Sony Computer Entertainment. It is the successor to the PlayStation Portable. The handheld includes two analog sticks, a 5-inch (130 mm) OLED multi-touch capacitive touchscreen, and supports Bluetooth, Wi-Fi and optional 3G.' },
        
		'wii': { color: '#81cceb', vendor: 'Nintendo', year: '2006', summary: 'The Wii is a home video game console released by Nintendo on November 19, 2006. As a seventh-generation console, the Wii competes with Microsofts Xbox 360 and Sonys PlayStation 3. Nintendo states that its console targets a broader demographic than that of the two others. As of the first quarter of 2012, the Wii leads its generation over PlayStation 3 and Xbox 360 in worldwide sales, with more than 101 million units sold; in December 2009, the console broke the sales record for a single month in the United States. The Wii introduced the Wii Remote controller, which can be used as a handheld pointing device and which detects movement in three dimensions. Another notable feature of the console is the now-defunct WiiConnect24, which enabled it to receive messages and updates over the Internet while in standby mode. Like other seventh-generation consoles, it features a game download service, called "Virtual Console", which features emulated games from past systems. It succeeded the Nintendo GameCube, and early models are fully backwards-compatible with all GameCube games and most accessories. Nintendo first spoke of the console at the 2004 E3 press conference and later unveiled it at the 2005 E3. Nintendo CEO Satoru Iwata revealed a prototype of the controller at the September 2005 Tokyo Game Show. At E3 2006, the console won the first of several awards. By December 8, 2006, it had completed its launch in the four key markets. In late 2011, Nintendo released a reconfigured model, the "Wii Family Edition", which lacks Nintendo GameCube compatibility; this model was not released in Japan. The Wii Mini, Nintendos first major console redesign since the compact SNES, succeeded the standard Wii model and was released first in Canada on December 7, 2012. The Wii Mini can only play Wii optical discs, as it omits GameCube compatibility and all networking capabilities. The Wiis successor, the Wii U, was released on November 18, 2012. On October 20, 2013, Nintendo confirmed it had discontinued production of the Wii in Japan and Europe, although the Wii Mini is still in production and available in Europe.' },
        
		'wswan': { color: '#77cbbd', vendor: 'Bandai', year: '1999', summary: 'The Bandai WonderSwan, usually just referred to as WonderSwan, is a fifth generation (1993-2005) handheld video game console developed and distributed by Bandai Co., Ltd. It was released on March 4, 1999 in Japan at a retail price of ¥4,800. The console was not released outside of Japan. The WonderSwan system had a low price point and long battery life which made it a formable competitor to Nintendo in Japan. The console was discontinued in Mid to late 2003.' },
        
		'wswanc': { color: '#42b1e6', vendor: 'Bandai', year: '1999', summary: 'The Bandai WonderSwan Color, usually just referred to as WonderSwan Color, is a fifth generation (1993-2005) handheld video game console developed and distributed by Bandai Co., Ltd. It was released on December 9, 2000 in Japan at a retail price of ¥6,900. The console was not released outside of Japan. The WonderSwan Color was backwards compatible to the Wonderswan and still held a long lasting battery life. The console was discontinued in mid to late 2003.' },
        
		'x68000': { color: '#6b6d71', vendor: 'Sharp', year: '1987', summary: 'The X68000 is a home computer created by Sharp Corporation, first released in 1987, sold only in Japan.  The first model features a 10 MHz Motorola 68000 CPU (hence the name), 1 MB of RAM, and no hard drive; the last model was released in 1993 with a 25 MHz Motorola 68030 CPU, 4 MB of RAM, and optional 80 MB SCSI hard drive. RAM in these systems is expandable to 12 MB, though most games and applications do not require more than 2 MB.' },
        
		'zxspectrum': { color: '#9a2611', vendor: 'Sinclair', year: '1982', summary: 'The ZX Spectrum is an 8-bit personal home computer released in the United Kingdom in 1982 by Sinclair Research Ltd. It was the follow-up to the Sinclair ZX81. The Spectrum was ultimately released as eight different models (although the models after the Spectrum 128K were technically developed and manufactured by Amstrad), ranging from the entry level model with 16 kB RAM released in 1982 to the ZX Spectrum +3 with 128 kB RAM and built in floppy disk drive. The Spectrum was among the first mainstream audience home computers in the UK, similar in significance to the Commodore 64 in the USA. The Commodore 64, BBC Microcomputer and later the Amstrad CPC range were major rivals to the Spectrum in the UK market during the early 1980s.' },
    };
}
