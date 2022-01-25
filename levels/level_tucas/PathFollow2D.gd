extends PathFollow2D

export (int) var speed

func _ready():
	set_process(false)
	
func run():
	set_process(true)

func _process(delta):
	offset += speed
	if unit_offset==1:
		offset = 0
