extends "res://levels/level_pedo/torres/torre.gd"

var cost 

func _ready():
	attackType = "hard"
	cost = Utils._get_main_node().hardCost
	upCost = cost * 1.2 

func upgrade():
	damage *= 1.5
	upCost*=1.2
	
