extends Area2D


signal player_hurt

var pos_limit = Vector2()
func _ready() -> void:
	randomize()
	global_position = Vector2(randi()%900 + 100,randi()%250+50)
	connect("player_hurt",Utils._get_main_node(),"is_player_hurt")
	$AnimationPlayer.play("acid_throw")
func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.is_in_group("proyectil"):
		queue_free()


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if !Utils._get_main_node().is_hidden:
		Utils._get_main_node().player_life -= 10
		emit_signal("player_hurt")
	queue_free()
