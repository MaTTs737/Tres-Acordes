extends Sprite

func _ready() -> void:
	$AnimationPlayer.play("kill")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	Utils._get_main_node().lost = true
