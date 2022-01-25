extends Node

onready var current_level = $intro


func _ready() -> void:
	$intro.connect("change_level",self,"handle_level_change")
	
	
func handle_level_change (current_level_name: String) -> void:
	var next_level
	match current_level_name:
		"intro":
			next_level = load ("res://levels/level_firefox/level_firefox_1.tscn")
		_:
			return
	remove_child(current_level)
	current_level.queue_free()
	next_level = next_level.instance()
	add_child(next_level)
	next_level.connect("change_level",self,"handle_level_change")
	current_level = next_level


