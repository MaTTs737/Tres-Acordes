extends TileMap

onready var player = Utils._get_main_node().get_node("player_esc")

func _ready():
	pass # Replace with function body.

func get_enemy_pos():
	randomize()
	var pos = map_to_world(Utils.choise_list(get_used_cells()))
	return pos

func get_edu_pos():
	return Utils._get_main_node().get_node("edu2").position

func get_player_pos():
	var pos = player.position
	return pos
