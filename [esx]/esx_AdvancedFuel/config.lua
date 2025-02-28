petrolCanPrice = 25

lang = "en"
-- lang = "fr"

settings = {}
settings["en"] = {
	openMenu = "Presiona ~g~E~w~ para abrir el menú.",
	electricError = "~r~Tienes un vehículo eléctrico.",
	fuelError = "~r~No estás en un buen lugar.",
	buyFuel = "comprar gasolina",
	liters = "litros",
	percent = "porciento",
	confirm = "Confirmar",
	fuelStation = "Gasolinera",
	boatFuelStation = "Estación de servicio | Barco",
	avionFuelStation = "Estación de servicio | Avión ",
	heliFuelStation = "Estación de servicio | Helicóptero",
	getJerryCan = "Presiona ~g~E~w~ para comprar una lata de gasolina ("..petrolCanPrice.."$)",
	refeel = "Presiona ~g~E~w~ para recargar el vehículo.",
	YouHaveBought = "Has comprado ",
	fuel = " litros de gasolina",
	price = "precio"
}

settings["fr"] = {
	openMenu = "Appuyez sur ~g~E~w~ pour ouvrir le menu.",
	electricError = "~r~Vous avez une voiture électrique.",
	fuelError = "~r~Vous n'êtes pas au bon endroit.",
	buyFuel = "acheter de l'essence",
	liters = "litres",
	percent = "pourcent",
	confirm = "Valider",
	fuelStation = "Station essence",
	boatFuelStation = "Station d'essence | Bateau",
	avionFuelStation = "Station d'essence | Avions",
	heliFuelStation = "Station d'essence | Hélicoptères",
	getJerryCan = "Appuyez sur ~g~E~w~ pour acheter un bidon d'essence ("..petrolCanPrice.."$)",
	refeel = "Appuyez sur ~g~E~w~ pour remplir votre voiture d'essence.",
	YouHaveBought = "Vous avez acheté ",
	fuel = " litres d'essence",
	price = "prix"
}


showBar = false
showText = true


hud_form = 1 -- 1 : Vertical | 2 = Horizontal
hud_x = 0.175
hud_y = 0.885

text_x = 0.2700
text_y = 0.940


electricityPrice = 1 -- NOT RANOMED !!

randomPrice = false --Random the price of each stations
price = 1 --If random price is on False, set the price here for 1 liter
