extends KinematicBody2D

onready var soundPlayer = $death

signal life_changed
signal got48

export (PackedScene) var proyectil
export(int) var run_speed
export(int) var jump_speed
export(int) var gravity
export(int) var life

enum {IDLE, RUN, HURT, JUMP, DEAD}

var state
var anim
var new_anim
var velocity = Vector2()
var max_jump = 18
var jump_count = 0
var facing = 1
var current_facing = facing
var tucas = 0

func start(pos,lifes,tuca):
	life = lifes
	tucas = tuca
	position = pos
	show()
	change_state(IDLE)
	emit_signal("life_changed", life)

func _ready():
	change_state(IDLE)
	emit_signal("life_changed",life)

func change_state(new_state):
	state = new_state

	match state:
		IDLE:
			new_anim = 'idle'
		RUN:
			new_anim = 'run'
		HURT:
#			new_anim = 'hurt'
#			$HurtAudio.play()
			get_hurt()
		JUMP:
			new_anim = 'jump'
			jump_count = 1
		DEAD:
			die()

func _process(delta):
	if tucas == 48:
		tucas = 0
		emit_signal("got48")
	velocity.y += gravity * delta
	get_input()
	flip_x()
	
	if new_anim != anim:
		anim = new_anim
		$AnimationPlayer.play(anim)
	
	velocity = move_and_slide(velocity, Vector2.UP)
#	if velocity.y > 0:
#		$HitBox/CollisionShape2D.disabled = false
#	else: $HitBox/CollisionShape2D.disabled =true
	hit_enemy()
	
func get_input():
	if state == HURT or state == DEAD:
		return
	
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_up")
	var shoot = Input.is_action_just_pressed("attack")
		
	velocity.x = 0
	
	if right:
		velocity.x += run_speed
		facing = 1
	
	if left:
		velocity.x -= run_speed
		facing = -1
		
	if jump and state == JUMP and jump_count < max_jump:
		new_anim = 'jump'
		velocity.y = jump_speed
		jump_count += 1
#		if jump_count==3:
#			max_jump = 2
	
	if jump and is_on_floor():
		change_state(JUMP)
		velocity.y = jump_speed
	
	if state == IDLE and velocity.x != 0:
		change_state(RUN)
	
	if state == RUN and velocity.x == 0:
		change_state(IDLE)
	
	if state in [IDLE, RUN] and !is_on_floor():
		change_state(JUMP)
	
	if state == JUMP and is_on_floor():
		change_state(IDLE)
	
	if state == JUMP and velocity.y > 0:
		new_anim = 'jump'

func hit():
	if state != HURT:
		change_state(HURT)

func get_hurt():
	velocity.y = -200
	velocity.x = -100 * sign(velocity.x)
	life -= 1
	emit_signal('life_changed', life)
	yield(get_tree().create_timer(0.5), 'timeout')
	change_state(IDLE)
	
	if life <= 0:
		change_state(DEAD)

func die():
	soundPlayer.play()
	yield(soundPlayer,"finished")
	hide()

func flip_x():
	if facing !=0:
		if current_facing != facing:
			current_facing = facing
			scale.x *= -1

func hit_enemy():
	if state == HURT:
		return

	for slide in range(get_slide_count()):
		var collision = get_slide_collision(slide)
		
		if collision.collider.is_in_group('enemies'):
			var player_feet = (position + $CollisionShape2D.shape.extents).y
			
			if player_feet < collision.collider.position.y:
				collision.collider.die()
				velocity.y = -200
			else:
				if collision.collider.is_in_group("edu"):
					collision.collider.hurt()
				hit()
