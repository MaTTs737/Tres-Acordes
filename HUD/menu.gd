extends CanvasLayer

onready var startButton = $Control/startButton
onready var rutaButton = $Control/MarginContainer/HBoxContainer/VBoxContainer/rutaButton
onready var schoolButton = $Control/MarginContainer/HBoxContainer/VBoxContainer/schoolButton
onready var alcButton = $Control/MarginContainer/HBoxContainer/VBoxContainer/alcButton
onready var jumpButton = $Control/MarginContainer/HBoxContainer/VBoxContainer/jumpButton
onready var pnButton = $Control/MarginContainer/HBoxContainer/VBoxContainer/pnButton
onready var zombiButton = $Control/MarginContainer/HBoxContainer/VBoxContainer/zombiButton
onready var torresButton = $Control/MarginContainer/HBoxContainer/VBoxContainer/torresButton

onready var level_list = [
	"res://levels/level_ruta/level_ruta.tscn",
	"res://levels/level_escuela/levelSecu.tscn",
	"res://levels/level_alc/level_alcantarillas.tscn",
	"res://levels/level_mago/level_world.tscn",
	"res://levels/level_zombi/level_zombis_policia.tscn",
	"res://levels/level_zombi/level2/level_zombis_policia_2.tscn",
	"res://levels/level_pedo/level_pedo.tscn"
]

onready var lvl_button_list = [
	rutaButton,
	schoolButton,
	alcButton,
	jumpButton,
	pnButton,
	zombiButton,
	torresButton
]

var level
var level_order = 0

signal new_scene(scene)

func _ready():
	for i in lvl_button_list:
		i.hide()
	lvl_button_list[level_order].show()

func _on_startButton_pressed():
	if level != null:
		get_tree().change_scene(level)
#
#func _on_levelsButton_pressed():
#	for button in lvl_button_list:
#		button.show()

#func _on_rutaButton_pressed():
#	for button in lvl_button_list:
#		if button != rutaButton:
#			button.hide()
#	level = level_list[0]
#
#func _on_alcButton_pressed():
#	for button in lvl_button_list:
#		if button != alcButton:
#			button.hide()
#	level = level_list[2]
#
#func _on_schoolButton_pressed():
#	level = level_list[1]
#	for button in lvl_button_list:
#		if button != schoolButton:
#			button.hide()
#
#func _on_jumpButton_pressed():
#	level = level_list[3]
#	for button in lvl_button_list:
#		if button != jumpButton:
#			button.hide()
#
#func _on_pnButton_pressed():
#	level = level_list[4]
#	for button in lvl_button_list:
#		if button != pnButton:
#			button.hide()
#
#func _on_tiendaButton_pressed():
#	level = level_list[5]
#	for button in lvl_button_list:
#		if button != tiendaButton:
#			button.hide()

#func _on_zombiButton_pressed():
#	level = level_list[5]
#	for button in lvl_button_list:
#		if button != zombiButton:
#			button.hide()
#
#func _on_torresButton_pressed():
#	level = level_list[6]
#	for button in lvl_button_list:
#		if button != torresButton:
#			button.hide()

func _on_leftButton_pressed():
	if level_order > 0:
		level_order -= 1
		level = level_list[level_order]
		for i in lvl_button_list:
			i.hide()
		lvl_button_list[level_order].show()

func _on_rightButton_pressed():
	if level_order < 6:
		level_order += 1
		level = level_list[level_order]
		for i in lvl_button_list:
			i.hide()
		lvl_button_list[level_order].show()
