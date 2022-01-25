extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if player != null and get_parent().unit_offset<0.98:
		player.global_position = global_position
	elif get_parent().unit_offset > 0.99:
		player = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Position2D_body_entered(body):
	player = body


func _on_Position2D_area_entered(area):
	player= area
