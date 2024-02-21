extends Node2D

# The game button object
class GameButton extends Node2D:
	var label
	var labelText
	var button
	var buttonText
	var id
	var price
	var description = "NOOOOO"
	var index = 0
	var titleText = "Omnipotent"
	var titled = false
	var active = false
	var parent
	var stage = 0
	var clicks = 0
	var currency = []
	#================================= Particle ======================#
	var particle = preload("res://Prefabs/press_particle.tscn")
	#================================= Particle ======================#
	#================================================#
	#
	#	Function: createParticle
	#	Description: makes fish a quarter of the price
	#
	#================================================#
	func createParticle():
		var obj = particle.instantiate()
		obj.emitting = true
		obj.position = button.position
		button.add_sibling(obj) 
	
	func updateText():
		button.text = buttonText
	
	func changeTitle():
		titled = true
		
	
	func titleNormal():
		titled = false
	
	func clickAdd():
		clicks += 1

var rValues = ""

# Load variables
var labelsTLoad = []
var buttonsTLoad = []
var namesLoad = []
var buttons = []
var functions = []
var prices = []
var descriptions = []
var titleText = "Omnipotent"
var stage = []
var currency = []

var headers = []

const priceIncrease = 1.2
#========================================= Prices ===================================#
@export_group("Prices")
@export var shovelPrice = 10
@export var grandpaPrice = 50
@export var fishPrice = 10
@export var polePrice = 30
@export var cardPrice = 6000
@export var powerPrice = 20000
@export var babyFishPrice = 10000
@export var babyWormPrice = 10000000
@export var unlockPrice = 1000000
@export var offerPrice = 100000
@export var sWPrice = 10000
@export var sFPrice = 5000
@export var goatPrice = 200
@export var licensePrice = 2000
#==================================================================================#
#====#
#====#
#====#
#========================================= Rates ===================================#
@export_group("Rates")
@export var shovelMultiple = 1
@export var grandpaHeighten = 10
@export var fishMultiple = 30
@export var knowMultiple = 50
@export var powerMultiple = 10000
#==================================================================================#
#====#
#====#
#====#
#========================================= Upgrades ===================================#
@export_group("Upgrades")
@export var shovelRise = 1.2

@export var fishRise = 1.15
@export var knowRise = 1.2
@export var powerRise = 1.1
#==================================================================================#
#====#
#====#
#====#
#========================================= Price Rises ===================================#
@export_group("Price Rises")
@export var grandpaPriceRise = 1.15
@export var sFPriceRise = 1.15
@export var goatPriceRise = 1.15
#==================================================================================#
#====#
#====#
#====#
#====#
#====#
#====#
#====#
#====#
#====#
#==================================================================================#
# Auto Run Through Variables
var autoTimer = 0
var autoActive = false
var autoRate = 1
var autoMode = "Off"
#==================================================================================#
#====#
#====#
#====#
#================================= RNG Variables ======================#
# Random Number Generator
var rng = RandomNumberGenerator.new()
#================================= RNG Variables ======================#
#====#
#====#
#====#
#================================= Shovel Variables ======================#
# Shovel variables
var shovelLevel = 1
#================================= Shovel Variables ======================#
#====#
#====#
#====#
#================================= Grandpa Variables ======================#
# Grandpa variables
var grandpaChance = 5
var grandpaActive = true
#================================= Grandpa Variables ======================#
#====#
#====#
#====#
#================================= Worm Variables ======================#
# Worms variables
var worms = 0
var wormActive = true
#================================= Worm Variables ======================#
#====#
#====#
#====#
#================================= Fish Variables ======================#
# Fish variables
var fish = 0
var fishActive = false
var poleLevel = 1
#================================= Fish Variables ======================#
#====#
#====#
#====#
#================================= Fishing Licence ======================#

#================================= Fishing Licence ======================#
#====#
#====#
#====#
#================================= Object Variables ======================#
var objIndex = 0
#================================= Object Variables ======================#
#====#
#====#
#====#
#================================= Knowledge Variables ======================#
var knowledge = 0
var knowledgeActive = false
#================================= Knowledge Variables ======================#
#====#
#====#
#====#
#================================= Offer Variables ======================#

#================================= Offer Variables ======================#
#====#
#====#
#====#
#================================= Power Variables ======================#
var power = 0
var powerActive = false
var stager = 0
var stages = [0,0,0,0]
#================================= Power Variables ======================#
#====#
#====#
#====#
#================================= Resolution Variables ======================#
var resButton = preload("res://Prefabs/resolution_button.tscn")
var wormRain = preload("res://Prefabs/worm_rain.tscn")
#================================= Resolution Variables ======================#
#====#
#====#
#====#
#================================================#
#
#	Function: add_button
#	Description: add button to gamebutton class
#
#================================================#
func add_button(named, labelsText="Label", buttonsText="Button", function=testFunc, staged = 0, cur = ["Worms"]):
	var but = GameButton.new()
	
	if (get_node(named) && but):
		but.index = objIndex
		objIndex += 1
		but.id = named
		but.labelText = labelsText
		but.buttonText = buttonsText
		but.parent = get_node(named)
		but.button = get_node(named + "/Button/Hype")
		but.label = get_node(named + "/Label/Label")
		but.button.connect("pressed", function)
		#but.button.connect("pressd", but.createParticle)
		but.button.connect("pressed", but.clickAdd)
		but.button.connect("mouse_entered", but.changeTitle)
		but.button.connect("mouse_exited", but.titleNormal)
		but.currency = cur
		but.stage = staged
		but.parent.visible = false
		buttons.append(but)
		print("Successfully Loaded: " + named)
	else:
		print("Failed to Load: " + named)
		but.queue_free()
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: revealStage
#	Description: Reveal the stage of buttons
#
#================================================#
func revealStage(stg):
	stager = stg
	for obj in buttons:
		autoRate = 0.2
		autoMode = "Slow"
		if (obj.stage == stg):
			obj.parent.visible = true
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: revealStage
#	Description: Reveal the stage of buttons
#
#================================================#
func hideAllStages():
	powerActive = false
	knowledgeActive = false
	fishActive = false
	wormActive = false
	autoMode = "Off"
	autoActive = false
	print("Auto Off")
	writeToFile()
	var instance = resButton.instantiate()
	instance.get_child(0).connect("pressed", quick)
	add_sibling(instance)
	print("You Win!!!!!")
	for obj in buttons:
		obj.parent.visible = false

func quick():
	power += 1000000000000
	knowledge += 1000000000000
	worms += 1000000000000
	fish += 1000000000000
	print("yesssssssssssssssss")

var f
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: _ready
#	Description: Ready up the scene 
#
#================================================#
# Called when the node enters the scene tree for the first time.
func _ready():
	# Shitty Way
	namesLoad = ["WormsButton", "ShovelButton","GrandpaButton","FishButton","FishingPoleButton","LicenseButton"]
	labelsTLoad = ["Nothing"," Worms", " Worms"," Worms"," Fish"," Fish"]
	buttonsTLoad = ["Dig Up Worms","Upgrade Shovel", "Ask Grandpa For\nFishing Pole", "Go Fishing", "Upgrade fishingpole", "Fishing License"]
	functions = [digForWorms,upgradeShovel,askGrandpa,goFish,upgradePole,buyLicense]
	stage = [0,0,0,1,1,1]
	currency = [["Nothing"], ["Worms"], ["Worms"], ["Worms"], ["Fish"], ["Fish"]]
	
	# ===================== Stage 1 ======================== #
	addDetails("LibraryCardButton", " Fish", "Nothing", applyLibrary, 1, ["Fish"])
	
	# ===================== Stage 2 ======================== #
	addDetails("ReadBooksButton", "Nothing", "Read Books", readBooks, 2, ["Nothing"])
	addDetails("StudyWormsButton", " Worms", "Study Worms", studyWorms, 2, ["Worms"])
	addDetails("StudyFishButton", " Fish", "Study Fish", studyFish, 2, ["Fish"])
	addDetails("GoatButton", " Knowledge", "Talk To Goat", talkGoat, 2, ["Knowledge"])
	addDetails("OfferingButton", " Knowledge", "Offer Fish and\nWorms to the Gods", offerFish, 2, ["Knowledge"])
	
	# ===================== Stage 3 ======================== #
	addDetails("PowerButton", " Knowledge", "GAIN POWER", gainPower, 3, ["Knowledge"])
	addDetails("BabyButton", " Fish", "Give Fish\nWorm Baby to Goat", makeBaby, 3, ["Worms", "Fish"])
	addDetails("UnlockButton", " Power", "Unlock Omnipotence", unlock, 3, ["Power"])
	
	f = FileAccess.open("res://Data.txt", FileAccess.WRITE)
	
	var i = 0
	for id in namesLoad:
		add_button(id,labelsTLoad[i],buttonsTLoad[i],functions[i], stage[i])
		i += 1
	
	# Auto Button Initialization
	var autoNodeBF = get_node("AutoButtonFast/Button")
	autoNodeBF.connect("pressed", autoStartFast)
	autoNodeBF.text = "Auto\nFast"
	
	var autoNodeBS = get_node("AutoButtonSlow/Button")
	autoNodeBS.connect("pressed", autoStartSlow)
	autoNodeBS.text = "Auto\nSlow"
	
	#Reveal the first stage
	revealStage(0)
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: addDetails
#	Description: update funnel of arrays for game
#				 objects
#
#================================================#
func addDetails(named="WormShovel", label=" Worms", buttonT="Button LOL", function=testFunc, stg=1, cur = ["Worms"]):
	labelsTLoad.append(label)
	namesLoad.append(named)
	buttonsTLoad.append(buttonT)
	functions.append(function)
	stage.append(stg)
	currency.append(cur)
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: headersUpdate
#	Description: update header text
#
#================================================#
func headersUpdate():
	get_node("WormHeader/Label").text = "Worms:"
	get_node("WormHeader/Value").text = str(int(worms))
	get_node("FishHeader/Label").text = "Fish:"
	get_node("FishHeader/Value").text = str(int(fish))
	get_node("KnowledgeHeader/Label").text = "Knowledge:"
	get_node("KnowledgeHeader/Value").text = str(int(knowledge))
	get_node("PowerHeader/Label").text = "Power:"
	get_node("PowerHeader/Value").text = str(int(power))
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: _process
#	Description: test button function
#
#================================================#
func _process(delta):
	
	#==================================== Auto Run ==========================================#
	autoRun(delta)
	# autoRunSmart(delta)
	# autoRunRandom(delta)
	#==================================== Auto Run ==========================================#
	
	if (Input.is_action_just_pressed("Debug")):
		writeToFile()
	
	#=========================================#
	prices  = [0, shovelPrice, grandpaPrice, fishPrice, polePrice, licensePrice, cardPrice, 0, sWPrice, sFPrice, goatPrice, offerPrice, powerPrice, babyFishPrice, unlockPrice]
	descriptions = ["Dig up "+str(shovelMultiple)+" yummy yummy worms.",
	"Upgrade Shovel to get more worms per click.",
	str(grandpaChance)+"% Chance of getting fishing pole from Grandpa.",
	"Fish for " + str(fishMultiple) + "fish.",
	"Upgrade your fishing pole",
	"Decrease the fish and worm price by 10%", 
	"50% Chance of getting a library card.",
	"Gain " + str(knowMultiple) + " knowledge.",
	"Cut and Study Worms",
	"Gut and Study Fish",
	"Ask Goat the Secrets of the Universe.",
	"Offer Worms and fish to the gods of Zathradez.",
	"Gain "+str(powerMultiple)+" Zathradez Power","Increase your ability to gain power\nby tricking goat wish fish/worm baby","Unlock Omnipotence and truly see\nthe world for the first time"]
	var buttonsText = [0,
	"Upgrade Shovel\n(Lvl. "+ str(shovelLevel)+")",
	"Ask for Fishingpole",
	"Fish",
	"Upgrade Fishingpole\n(Lvl. " + str(poleLevel) + ")",
	"Bribe Lakekeeper", 
	"Apply for\nLibrary Card",
	0,
	"Study Worms",
	"Study Fish",
	"Talk to The Goat",
	"Offer Fish and\nWorms to the Gods",
	"Gain Power", "Give Fish/Worm\nBaby to Goat", "Unlock Omnipotence"]
	#=========================================#
	
	titleText = "Omnipotent"
	
	var i = 0
	for obj in buttons:
		obj.updateText()
		obj.description = descriptions[i]
		
		print(currency[i].size())
		#fadeOut
		if (currency[i].size() == 1 && currency[i][0] == "Worms"):
			if (worms < prices[i] || prices[i] == -1):
				obj.button.disabled = true
			else:
				obj.button.disabled = false
		elif (currency[i].size() == 1 && currency[i][0] == "Fish"):
			if (fish < prices[i] || prices[i] == -1):
				obj.button.disabled = true
			else:
				obj.button.disabled = false
		elif (currency[i].size() == 1 && currency[i][0] == "Knowledge"):
			if (knowledge < prices[i] || prices[i] == -1):
				obj.button.disabled = true
			else:
				obj.button.disabled = false
		elif (currency[i].size() == 1 && currency[i][0] == "Power"):
			if (power < prices[i] || prices[i] == -1):
				obj.button.disabled = true
			else:
				obj.button.disabled = false
		elif (currency[i].size() > 1 && currency[i][0] == "Worms" && currency[i][1] == "Fish"):
			if (worms < prices[i] || fish < babyFishPrice || prices[i] == -1):
				obj.button.disabled = true
			else:
				obj.button.disabled = false
		
		if (obj.titled):
			titleText = obj.description
		
		if prices[i] != 0:
			obj.label.text = str(int(prices[i])) + obj.labelText
			obj.button.text = str(buttonsText[i])
			if currency[i].size() > 1:
				obj.label.text += " "+str(babyWormPrice) + " Worms"
		else:
			obj.label.text = obj.labelText
			
		if (prices[i] == -1):
			obj.label.text = "Sold Out"
			
		i += 1
	
	headersUpdate()
	titleUpdate()
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: buyLicense
#	Description: makes fish a quarter of the price
#
#================================================#
func buyLicense():
	if (fish >= licensePrice):
		fish -= licensePrice
		fishPrice *= 0.1
		shovelPrice *= 0.1
		licensePrice *= 1.5
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: buyLicense
#	Description: makes fish a quarter of the price
#
#================================================#
func writeToFile():
	if f:
		print("Wrote To File")
		var string = ""
		for button in buttons:
			string += str(button.id) + " , " + str(button.clicks) + "\n"
		var i = 1
		for stg in stages:
			string += "Phase " + str(i) + ", " + str(stg) + "\n"
			i += 1
		string += rValues
		f.store_string(string)

		return
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: autoStartFast
#	Description: Turns on auto play at a quick 
#	             rate
#
#================================================#
func autoStartFast():
	if (autoActive && autoMode == "Fast"):
		autoActive = false
		autoMode = "Off"
		print("Fast Auto OFF")
	else:
		autoMode = "Fast"
		autoActive = true
		autoRate = 0
		print("Fast Auto ON")
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: autoStartSlow
#	Description: Turns on auto play at a slow rate
#
#================================================#
func autoStartSlow():
	if (autoActive && autoMode == "Slow"):
		autoActive = false
		autoMode = "Off"
		print("Slow Auto OFF")
	else:
		autoMode = "Slow"
		autoActive = true
		autoRate = 0.05
		print("Slow Auto ON")
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: studyWorms
#	Description: makes fish a quarter of the price
#
#================================================#
func studyWorms():
	if (worms >= sWPrice && knowledgeActive):
		worms -= sWPrice
		sWPrice *= 1.5
		knowledge += knowMultiple*2
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: gainPower
#	Description: 
#
#================================================#
func gainPower():
	if (knowledge >= powerPrice && powerActive):
		knowledge -= powerPrice
		power += powerMultiple
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: makeBaby
#	Description: 
#
#================================================#
func makeBaby():
	if (worms >= babyWormPrice && fish >= babyFishPrice && powerActive):
		worms -= babyWormPrice
		fish -= babyFishPrice
		babyWormPrice *= 1.3
		babyFishPrice *= 1.3
		powerMultiple *= powerRise
		
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: makeBaby
#	Description: 
#
#================================================#
func unlock():
	if (power >= unlockPrice && powerActive):
		power -= unlockPrice
		hideAllStages()
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: offerFish
#	Description: makes fish a quarter of the price
#
#================================================#
func offerFish():
	if (knowledge >= offerPrice && offerPrice != -1 && knowledgeActive):
		knowledge -= offerPrice
		offerPrice = -1
		revealStage(3)
		powerActive = true
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: studyFish
#	Description: makes fish a quarter of the price
#
#================================================#
func studyFish():
	if (fish >= sFPrice && knowledgeActive):
		fish -= sFPrice
		sFPrice *= sFPriceRise
		knowledge += knowMultiple*2.5
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: studyWorms
#	Description: makes fish a quarter of the price
#
#================================================#
func talkGoat():
	if (knowledge >= goatPrice && knowledgeActive):
		knowledge -= goatPrice
		goatPrice *= goatPriceRise
		knowMultiple *= knowRise
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: testFunc
#	Description: test button function
#
#================================================#
func testFunc():
	print("WTF")
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: autoRun
#	Description: test button function
#
#================================================#
func autoRun(delta):
	if autoActive:
		autoTimer += delta
		if (autoTimer >= autoRate):
			autoTimer = 0
			var i = 0
			for function in functions:
				function.call()
				stages[stager] += 1
				clicks += 1
				if (buttons[i].button.disabled == false):
					buttons[i].button.emit_signal("pressed")
				if (clicks >= 100):
					clicks = 0
					rValues += "100 Clicks = Worms: " + str(worms) + "; Fish: " + str(fish)  + "; Knowledge: " + str(knowledge)  + "; Power: " + str(power) + "\n"
				i += 1
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: autoRunSmart
#	Description: Run the game more or less how a
#				 player
#
#================================================#
var clicks = 0
func autoRunSmart(delta):
	if (autoActive):
		autoTimer += delta
		
		if (autoTimer >= autoRate):
			autoTimer = 0
			goFish()
			digForWorms()
			readBooks()
			buyLicense()
			askGrandpa()
			applyLibrary()
			upgradeShovel()
			clicks += 1
			if (clicks >= 50):
				clicks = 0
				upgradePole()
		pass
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: autoRunSmart
#	Description: Run the game more or less how a
#				 player
#
#================================================#
func autoRunRandom(delta):
	if (autoActive):
		autoTimer += delta
		
		if (autoTimer >= autoRate):
			autoTimer = 0
			var number = rng.randi_range(0, functions.size()-1)
			functions[number].call()
		pass
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: goFish
#	Description: Add fish to fish pile
#
#================================================#
func goFish():
	if (worms > fishPrice && fishActive):
		fish += fishMultiple
		worms -= fishPrice
		fishPrice *= fishRise
	print("goFish")
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: upgradePole
#	Description: upgrades fish multiple
#
#================================================#
func upgradePole():
	if (fish >= polePrice && fishActive):
		fish -= polePrice
		polePrice *= 1.3
		fishMultiple *= fishRise
		fishPrice *= 0.8
		poleLevel += 1
	print("upgradePole")
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: readBooks
#	Description: upgrades fish multiple
#
#================================================#
func readBooks():
	if (knowledgeActive):
		knowledge += knowMultiple
	print("upgradePole")
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: digForWorms
#	Description: add worms to worm pile
#
#================================================#
func digForWorms():
	if (wormActive):
		worms += shovelMultiple
		print("digForWorms")
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: upgradeShovel
#	Description: upgrades shovel multiple
#
#================================================#
func upgradeShovel():
	print("upgradeShovel")
	if (worms >= shovelPrice && wormActive):
		worms -= shovelPrice
		shovelPrice *= 1.3
		shovelMultiple *= shovelRise
		shovelLevel += 1
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: askGrandpa
#	Description: discover the second stage
#
#================================================#
func askGrandpa():
	print("askGrandpa")
	
	if (worms >= grandpaPrice && grandpaActive && grandpaPrice != -1):
		worms -= grandpaPrice
		grandpaPrice *= grandpaPriceRise
		
		#====== Random Chance ======#
		var number = rng.randf_range(0,100)
		if (number <= grandpaChance):
			print("Grandpa feels generous today") 
			revealStage(1)
			fishActive = true
			grandpaActive = false
			grandpaPrice = -1
		else:
			print("Grandpa Denied You");
		#====== Random Chance ======#
		
		grandpaChance += grandpaHeighten
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: titleUpdate
#	Description: update descriptor bar
#
#================================================#
func titleUpdate():
	get_node("DescriptionHeader/Label").text = titleText
#================================================================================#
#====#
#====#
#====#
#================================================#
#
#	Function: applyLibrary
#	Description: test button function
#
#================================================#
func applyLibrary():
	if (fish >= cardPrice && fishActive && cardPrice != -1):
		fish -= cardPrice
		
		var number = rng.randf_range(0,100)
		if (number <= 50):
			revealStage(2)
			knowledgeActive = true
			cardPrice = -1
			print("Reveal Stage 2")
		else:
			cardPrice += 1000
#================================================================================#
