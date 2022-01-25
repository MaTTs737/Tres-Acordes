extends Area2D

signal on
signal off

func _ready():
	connect("on",Utils._get_main_node(),"putTowerOn")
	connect("off",Utils._get_main_node(),"putTowerOff")

func _on_Area2D_area_entered(_area):
	emit_signal("on")

func _on_Area2D_area_exited(_area):
	emit_signal("off")
