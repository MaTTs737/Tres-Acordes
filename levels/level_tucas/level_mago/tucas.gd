extends YSort

var tucas = []
var tucas_pos_x = []
var tucas_pos_y = []
var child_count = 0

const TUCA = preload("res://pickables/tuca.tscn")

func recopilar():
	for child in get_children():
		var pos = child.global_position
		tucas_pos_x.append(pos.x)
		tucas_pos_y.append(pos.y)
		child_count+=1
		tucas.append(child_count)

func _ready():
	recopilar()

func update_start():
	for child in get_children():
		child.queue_free()
		
	for pos in tucas:
		var child = TUCA.instance()
		child.global_position.x = tucas_pos_x[pos-1]
		child.global_position.y = tucas_pos_y[pos-1]
		child.connect("body_entered",Utils._get_main_node(),"_on_body_entered")
		add_child(child)
