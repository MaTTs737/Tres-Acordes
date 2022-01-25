extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	offset.x = get_parent().global_position.x-25
	offset.y = get_parent().global_position.y+50
