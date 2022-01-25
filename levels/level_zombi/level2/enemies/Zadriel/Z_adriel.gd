extends Area2D


var is_mad = false
var Zadriel_life = 10
var is_dead = false
var pistola = preload ("res://levels/level_zombi/level2/enemies/Attacks/Gun/ataque_Zadriel.tscn")
var is_mad_shots = 0



func _on_Timer_timeout() -> void:
	if is_dead or is_mad:
		return
	var attack = pistola.instance()
	$shoot_sound.play()
	attack.position.x = -113.461
	attack.position.y = 38.71
	attack.connect("player_hurt",Utils._get_level(),"is_player_hurt")
	add_child(attack)


func _on_Z_adriel_area_entered(area: Area2D) -> void:
	if area.is_in_group("proyectil"):
		Zadriel_life -= 10
		if Zadriel_life <= 0:
			is_dead = true
			hide()


func _on_Z_jaique_is_hurt() -> void:
	if is_dead:
		return
	is_mad = true
	$Timer_mad.start()
	$adriel_grito.play()


func _on_Timer_mad_timeout() -> void:
	if !is_mad or is_mad_shots>= 5 or is_dead:
		return
	var attack = pistola.instance()
	$shoot_sound.play()
	attack.position.x = -113.461
	attack.position.y = 38.71
	attack.connect("player_hurt",Utils._get_level(),"is_player_hurt")
	add_child(attack)
	is_mad_shots += 1
	if is_mad_shots >= 5:
		is_mad = false
		is_mad_shots = 0
		$Timer_mad.stop()
