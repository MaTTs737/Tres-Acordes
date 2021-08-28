extends Area2D

signal switchR
signal switchL
signal die
signal life_changed(life)

export (int) var speed
export (int) var maxLife

var life : int
var velocity = Vector2()

func _ready():
	life=maxLife
	emit_signal("life_changed",life)

func setup(pos):
	position=pos
	
func _physics_process(delta):
	get_input()
	translate(velocity*delta)
	
func get_input():
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	var right = Input.is_action_just_pressed("ui_right")
	var left = Input.is_action_just_pressed("ui_left")
	if up :
		velocity.y -= speed
	if down :
		velocity.y += speed
	else :
		velocity=Vector2.ZERO
	if right:
		emit_signal("switchR")
	if left:
		emit_signal("switchL")

func die(pos):
	print("You Died")
	position = pos
	life = maxLife
	emit_signal("life_changed",life)
	emit_signal("die")


func _on_player_area_entered(area):
	if area.is_in_group("enemies"):
		life-=1
		emit_signal("life_changed",life)
		area.queue_free()
