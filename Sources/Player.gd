extends KinematicBody2D

const ACCELERATION = 610
const FRICTION = 631
const MAX_SPEED = 90 

# -- The current velocity vector for the 'Player'.
var velocity = Vector2.ZERO
# -- The 'AnimationPlayer' responsible for this 'Player'.
onready var animation_player = $AnimationPlayer

func _physics_process(delta: float):
	var input_v = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	if input_v.x > 0:
		animation_player
	else:

	
	if input_v == Vector2.ZERO:
		# Slow down player
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	else:
		# Accelerate
		velocity = velocity.move_toward(input_v * MAX_SPEED, ACCELERATION * delta)

	velocity = move_and_slide(velocity)

func animate(input_v: Vector2D):
	if input_v.x > 0:
		animation_player.play("")