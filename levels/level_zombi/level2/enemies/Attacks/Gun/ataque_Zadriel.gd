extends Sprite

var attack_power = 10
signal player_hurt

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if !Utils._get_level().is_hidden:
		Utils._get_level().player_life -= attack_power
		emit_signal("player_hurt")
	queue_free()
