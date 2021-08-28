extends "res://enemy/enemy.gd"


var ruta_count = 0
var dirs = ["left","right"]

func ready():
	$switchTimer.start()

func _process(delta):
	if position.y >= Utils._get_view_size().y:
		queue_free()

func move():
	randomize()
	var dir = Utils.choise_list(dirs)
	match dir:
		"right":
			if ruta_count <=0 :
				position.x+=150
				ruta_count+=1
		"left":
			if ruta_count >0 :
				position.x-=150
				ruta_count-=1
	$switchTimer.wait_time=rand_range(2,4)
	$switchTimer.start()

func _on_switchTimer_timeout():
	move()

func _on_enemy_swapy_area_entered(area):
	if area.is_in_group("enemies"):
		velocity = area.velocity # Replace with function body.
