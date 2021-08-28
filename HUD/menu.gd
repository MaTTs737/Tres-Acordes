extends CanvasLayer

onready var startButton = $Control/MarginContainer/VBoxContainer/startButton
onready var levelsButton = $Control/MarginContainer/VBoxContainer/levelsButton
onready var rutaButton = $Control/MarginContainer/VBoxContainer/rutaButton
onready var schoolButton = $Control/MarginContainer/VBoxContainer/schoolButton
onready var alcButton = $Control/MarginContainer/VBoxContainer/alcButton
onready var jumpButton = $Control/MarginContainer/VBoxContainer/jumpButton
onready var pnButton = $Control/MarginContainer/VBoxContainer/pnButton
onready var cadButton = $Control/MarginContainer2/cadButton
onready var tiendaButton = $Control/MarginContainer/VBoxContainer/tiendaButton

onready var level_list = [
	"res://levels/level_ruta/level_ruta.tscn",
	"res://levels/level_escuela/levelSecu.tscn",
	"res://levels/level_alc/level_alcantarillas.tscn",
	"res://levels/level_mago/level_world.tscn",
	"res://levels/level_ papanoel/level_papanoel.tscn",
	"res://levels/level_tienda/tienda.tscn"
]

onready var lvl_button_list = [
	rutaButton,
	schoolButton,
	alcButton,
	jumpButton,
	pnButton,
]

var level

signal new_scene(scene)

func _ready():
	if AbstractPlayer.have_cad:
		cadButton.show()

func _on_startButton_pressed():
	if level != null:
		get_tree().change_scene(level)

func _on_levelsButton_pressed():
	for button in lvl_button_list:
		button.show()
	"""
	rutaButton.show()
	schoolButton.show()
	alcButton.show()
	jumpButton.show()
	pnButton.show()
	"""

func _on_rutaButton_pressed():
	for button in lvl_button_list:
		if button != rutaButton:
			button.hide()
	level = level_list[0]
	"""
	
	schoolButton.hide()
	alcButton.hide()
	jumpButton.hide()
	pnButton.hide()
	"""
func _on_alcButton_pressed():
	for button in lvl_button_list:
		if button != alcButton:
			button.hide()
	level = level_list[2]
	

func _on_schoolButton_pressed():
	level = level_list[1]
	for button in lvl_button_list:
		if button != schoolButton:
			button.hide()

func _on_jumpButton_pressed():
	level = level_list[3]
	for button in lvl_button_list:
		if button != jumpButton:
			button.hide()


func _on_pnButton_pressed():
	level = level_list[4]
	for button in lvl_button_list:
		if button != pnButton:
			button.hide()



func _on_tiendaButton_pressed():
	level = level_list[5]
	for button in lvl_button_list:
		if button != tiendaButton:
			button.hide()
