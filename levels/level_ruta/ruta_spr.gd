extends Sprite

export var velocity = Vector2()

func _process(delta):
	translate (velocity * delta)
	
	if position.y >= (Utils.view_size.y +1070):
		position.y=0
