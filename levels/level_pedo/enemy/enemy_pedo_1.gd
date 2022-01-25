extends Path2D

const enemy_follow = preload ("res://levels/level_pedo/enemy/enemy_pedo_1_follow.tscn")
const SON = preload("res://levels/level_pedo/enemy/enemy_pedo_little.tscn")

var current_offset

func _ready():
	pass


func spread():
	print("recibido")
	current_offset = 0.5
	for i in 3:
		var follow = enemy_follow.instance()
		var son = SON.instance()
		follow.unit_offset = current_offset
		
		add_child(follow)
		follow.add_child(son)
	
		current_offset -= 0.05
