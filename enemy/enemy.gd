extends Area2D

export var velocity = Vector2()
export var armor = 4 setget _set_armor

func _set_armor(value):
	armor=value

func _physics_process(delta):
	translate(velocity * delta)
	
