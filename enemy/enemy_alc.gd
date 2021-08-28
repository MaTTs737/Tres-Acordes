extends KinematicBody2D

export (int) var FRICTION
export (int) var SPEED
export (int) var MAX_LIFE

onready var playerDetection = $playerDetection
onready var sprite = $AnimatedSprite
onready var hurtBox = $HurtBox

const deathEffect = preload("res://effects/deathEffect.tscn")

enum {
	IDLE,
	WANDER,
	CHASE
}

var state = CHASE
var knockback = Vector2.ZERO
var velocity = Vector2.ZERO
var life

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			seeking(delta)
		WANDER:
			pass
		CHASE:
			chase(delta)
			
	
	velocity = move_and_slide(velocity)
	
func _ready():
	life = MAX_LIFE

func seeking(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	if playerDetection.can_see_player():
		state = CHASE
	

func wander(delta):
	pass

func chase(delta):
	var objetive = playerDetection.objetive
	if objetive != null:
		var direction = (objetive.global_position - global_position).normalized()
		velocity = velocity.move_toward(direction * SPEED, SPEED * delta)
		sprite.flip_h = velocity.x < 0
	else: state = IDLE
	


func die():
	queue_free()
	var enemyDeathEffect = deathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position


func _on_playerDetection_body_entered(body):
	pass # Replace with function body.


func _on_HurtBox_area_entered(area):
	life -= 1
	knockback = area.knockback_vector * 120
	hurtBox.create_hitEffect()
	if life == 0:
		die()
	
