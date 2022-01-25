extends VideoPlayer

export (String) var level_name = "level"

signal change_level (level_name)

func _ready() -> void:
	play()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pausa"):
		emit_signal("change_level",level_name)

func _on_Intro_finished() -> void:
	emit_signal("change_level",level_name)
