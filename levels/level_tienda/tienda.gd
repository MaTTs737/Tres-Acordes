extends Control

onready var playerCoinsLab = $MarginContainer/playerData/coinCountLab
onready var tucaCountLab = $MarginContainer/playerData/tucaCountLab
onready var costLab = $objCost/costLab

var tucas = 0 setget set_tucas
var have_cadillac = true
var have_coch = true
var player_coins = 0 setget set_player_coins
var cost = 0 setget set_cost
var currentItem

enum {
	CADILLAC = 500,
	COCH = 200
	TUCA = 5
}

func sell(item,quantity):
	var total = 0
	match item:
		CADILLAC:
			if have_cadillac and player_coins > CADILLAC and !AbstractPlayer.have_cad:
				total = CADILLAC
				have_cadillac = false
				AbstractPlayer.have_cad = true
			elif !have_cadillac or AbstractPlayer.have_cad: print("ya tenes un auto, malagradecido")
			else: print("tomatela,pobre")
		COCH:
			if have_coch and player_coins > COCH and !AbstractPlayer.have_coch:
				total = COCH
				have_coch = false
				AbstractPlayer.have_coch = true
			elif !have_coch or AbstractPlayer.have_coch : print("pero para, drogadicto q te pensa q los cago?")
			else : print("tomatela,pobre")
		TUCA:
			if (tucas > 0) and quantity <= tucas and 0 <= tucas - quantity and player_coins>= quantity*TUCA:
				tucas -= quantity
				total = quantity * TUCA
				AbstractPlayer.tucas += quantity
				set_tucas(AbstractPlayer.tucas)
			elif tucas<=0: print("no hay mas, falopero")
			else : print("tomatela,pobre")
	AbstractPlayer.coins -= total
	set_player_coins(AbstractPlayer.coins)
	

func set_player_coins(value):
	player_coins = value
	playerCoinsLab.text = str(player_coins)

func set_tucas(value):
	tucas = value
	tucaCountLab.text = str(tucas)

func set_cost(value):
	cost=value
	costLab.text = str(cost)
	
func _ready():
	set_player_coins(AbstractPlayer.coins)
	set_tucas(AbstractPlayer.tucas)

func _on_cadBut_pressed():
	set_cost(CADILLAC)
	currentItem = CADILLAC

func _on_cochBut_pressed():
	set_cost(COCH)
	currentItem = COCH

func _on_tucaBut_pressed():
	set_cost(TUCA)
	currentItem = TUCA

func _on_buyBut_pressed():
	sell(currentItem,1)


func _on_Button_pressed():
	get_tree().change_scene("res://HUD/menu.tscn")
