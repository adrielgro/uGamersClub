/*
    This script was developed by Piter Van Rujpen/TheGamerRespow for Vulkanoa (https://discord.gg/bzMnYPS).
    Do not re-upload this script without my authorization. (I only give authorization by PM on FiveM.net (https://forum.fivem.net/u/TheGamerRespow))
*/

var VK = new Object(); // DO NOT CHANGE
VK.server = new Object(); // DO NOT CHANGE

VK.backgrounds = new Object(); // DO NOT CHANGE
VK.backgrounds.actual = 0; // DO NOT CHANGE
VK.backgrounds.way = true; // DO NOT CHANGE
VK.config = new Object(); // DO NOT CHANGE
VK.tips = new Object(); // DO NOT CHANGE
VK.music = new Object(); // DO NOT CHANGE
VK.info = new Object(); // DO NOT CHANGE
VK.social = new Object(); // DO NOT CHANGE
VK.players = new Object(); // DO NOT CHANGE 

//////////////////////////////// CONFIG

VK.config.loadingSessionText = "Cargando la sesión..."; // Loading session text
VK.config.firstColor = [255, 255, 255]; // First color in rgb : [r, g, b]
VK.config.secondColor = [6, 131, 165]; // Second color in rgb : [r, g, b]
VK.config.thirdColor = [241, 230, 9]; // Third color in rgb : [r, g, b]

VK.backgrounds.list = [ // Backgrounds list, can be on local or distant(http://....)
    "img/1.jpg",
    "img/2.jpg",
    "img/3.jpg",
    "img/4.jpg",
];
VK.backgrounds.duration = 5000; // Background duration (in ms) before transition (the transition lasts 1/3 of this time)

VK.tips.enable = true; //Enable tips (true : enable, false : prevent)
VK.tips.list = [ // Tips list
    "¡Presiona la tecla \"Y\" para abrir tu iPhone!", // If you use double-quotes, make sure to put a \ before each double quotes
    "¡Presiona la tecla \"T\" para escribir en el chat del servidor!",
    "¡Presiona la tecla \"P\" para visualizar el mapa!",
    "¡Mantén pulsada la tecla \"Z\" para ver los jugadores conectados!",
];

VK.music.url = "music3.ogg"; // Music url, can be on local or distant(http://....) ("NONE" to desactive music)
VK.music.volume = 0.2; // Music volume (0-1)
VK.music.title = "CG1974 - Sleepwalking"; // Music title ("NONE" to desactive)
VK.music.submitedBy = "NONE"; // Music submited by... ("NONE" to desactive)

VK.info.logo = "https://ugamers.club/ext/planetstyles/flightdeck/store/Headerlogo800x300-01.png"; // Logo, can be on local or distant(http://....) ("NONE" to desactive)
VK.info.text = "NONE"; // Bottom right corner text ("NONE" to desactive) 
VK.info.website = "https://ugamers.club"; // Website url ("NONE" to desactive) 
VK.info.ip = "178.33.115.76:30121"; // Your server ip and port ("ip:port")

VK.social.discord = "NONE"; // Discord url ("NONE" to desactive)
VK.social.twitter = "/uGamersClub"; // Twitter url ("NONE" to desactive)
VK.social.facebook = "/uGamersClub"; // Facebook url ("NONE" to desactive)
VK.social.youtube = "NONE"; // Youtube url ("NONE" to desactive)
VK.social.twitch = "/uGamersClub"; // Twitch url ("NONE" to desactive)

VK.players.enable = true; // Enable the players count of the server (true : enable, false : prevent)
VK.players.multiplePlayersOnline = "@players jugadores en línea."; // @players equals the players count
VK.players.onePlayerOnline = "1 jugador en línea"; // Text when only one player is on the server
VK.players.noPlayerOnline = "Ningún jugador en línea."; // Text when the server is empty

////////////////////////////////
