extends PathFollow2D

#export (int) var normalSpeed
#
#var frozenSpeed = 50

var attack_power = 10
#var speed = 0

#func _ready():
#	speed = normalSpeed
	
func _process(delta: float) -> void:
	if get_child_count() > 0 and get_child(0).speed:
		set_offset(get_offset() + get_child(0).speed * delta)
		if (get_unit_offset() == 1):
			Utils._get_main_node().player_life -= attack_power
			queue_free()
