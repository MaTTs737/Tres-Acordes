extends YSort

var espejos_pos_x = []
var espejos_pos_y = []

var child_count = 0
var espejos = []
const ESPEJO = preload("res://enemy/enemy_espejo.tscn")

func recopilar():
	for child in get_children():
		var pos = child.global_position
		espejos_pos_x.append(pos.x)
		espejos_pos_y.append(pos.y)
		child_count+=1
		espejos.append(child_count)

func _ready():
	recopilar()

func update_start():
	for child in get_children():
		child.queue_free()

	for pos in espejos:
		var child = ESPEJO.instance()
		child.global_position.x = espejos_pos_x[pos-1]
		child.global_position.y = espejos_pos_y[pos-1]
		child.connect("got_hit",Utils._get_main_node(),"enemy_hurt")
		add_child(child)
