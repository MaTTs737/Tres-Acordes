extends Node2D

signal play_ending

func _ready() -> void:
	$scary_adriel.visible = false
	$scary_jaique.visible = false
	$scary_edu.visible = false




func _on_scary_anim_animation_finished(anim_name: String) -> void:
	emit_signal("play_ending")
