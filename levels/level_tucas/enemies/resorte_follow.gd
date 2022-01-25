extends PathFollow2D

func push():
	offset+=3

func pull():
	offset-=3
	
func _process(delta):
	if offset>0:
		push()
	else : pull()

func _on_pushTimer_timeout():
	push()


func _on_pullTimer_timeout():
	pull()
