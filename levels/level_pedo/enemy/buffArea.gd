extends Area2D

func heal():
	$Timer.start()
	$Particles2D.visible = true
	get_parent().life = get_parent().maxLife

func _on_Timer_timeout():
	$Particles2D.visible = false

func buff3():
	get_parent().buff3()
