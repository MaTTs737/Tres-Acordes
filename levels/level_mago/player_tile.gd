extends KinematicBody2D

export (int) var maxSpeed
export (int) var acceleration
export (int) var friction
export (int) var jump_speed
export(int) var gravity
export (int) var maxLife

onready var animationPlayer = $AnimationPlayer
onready var tucas = AbstractPlayer.tucas

signal life_changed(life)
signal die

var state = IDLE
var new_state
var anim : String
var new_anim : String
var facing : String
var life

enum { IDLE, MOVE, JUMP , DEAD }

var velocity = Vector2()

func update_start(pos):
	life = AbstractPlayer.maxLife
	position = pos
	state = IDLE
	self.show()
	self.scale = Vector2(1,1)
	emit_signal("life_changed",life)

func _ready():
	state = IDLE
	life = AbstractPlayer.life
	emit_signal("life_changed", life)

func _process(delta):
	if state != DEAD:
		get_input()
		
		if state == IDLE and velocity.x != 0:
			change_state(MOVE)
		if state == IDLE and !is_on_floor():
			change_state(JUMP)
		if state == MOVE and !is_on_floor():
			change_state(JUMP)
		if state == JUMP and is_on_floor():
			change_state(IDLE)
		if state == MOVE and velocity.x == 0:
			change_state(IDLE)
		
		animate(state)
		if !is_on_floor(): 
			velocity.y += gravity * delta
		move_and_slide(velocity, Vector2.UP)
	
func get_input():
	
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var jump = Input.is_action_just_pressed("ui_up")
	var attack = Input.is_action_just_pressed("attack")
	velocity.x = 0
	
	if left: 
		facing="left"
		velocity.x -= maxSpeed
	if right:
		facing="right"
		velocity.x += maxSpeed
	if jump and is_on_floor():
		velocity.y = -jump_speed
	if attack:
		animationPlayer.play("attack")
	
func change_state(new_state):
	state = new_state

func animate(state):
	match state:
		IDLE:
			new_anim="idle_"+facing
		MOVE:
			new_anim="move_"+facing
		JUMP:
			new_anim="jump_"+facing
	if new_anim != anim:
		anim=new_anim
		animationPlayer.play(anim)

func get_hurt():
	life -= 1
	if life <= 0:
		die()
	emit_signal("life_changed",life)

func die():
	state = DEAD
	emit_signal("die")
	self.hide()
	
func sucked():
	state = DEAD
	animationPlayer.play("sucked")
	yield(animationPlayer,"animation_finished")


func _on_HitBox_area_entered(area):
	pass # Replace with function body.

func _on_HurtBox_area_entered(area):
	get_hurt()
