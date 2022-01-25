extends Area2D


func _ready() -> void:
	$AnimationPlayer.play("kill")

func _on_Z_edu_area_entered(area: Area2D) -> void:
	if area.is_in_group("proyectil"):
		queue_free()


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	Utils._get_main_node().player_life -= 30
