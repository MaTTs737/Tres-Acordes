extends KinematicBody2D


#signal "die"
var drops = 10
var life = 100
var attack_power = 10
var direction: = Vector2(1,-1)
var speed: = Vector2(100,0)

func _physics_process(delta: float) -> void:
	move_and_slide(speed)


func die ():
	Utils._get_main_node().coins += drops
#	emit_signal (die)
	queue_free()

func gethurt (damage: int) -> void:
	life -= damage
	if life <= 0:
		die()

func _on_HurtBox_area_entered(area: Area2D) -> void:
	gethurt(area.damage)
