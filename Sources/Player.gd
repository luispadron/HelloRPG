extends KinematicBody2D

const ACCELERATION = 10
const FRICTION = 8
const MAX_SPEED = 100 

# -- The current velocity vector for the 'Player'.
var velocity = Vector2.ZERO

func _ready():
	pass 

func _physics_process(delta):
	var input_v = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	if input_v == Vector2.ZERO:
		# Slow down player
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
	else:
		# Accelerate
		velocity = velocity.move_toward(input_v * MAX_SPEED, ACCELERATION)


	move_and_slide(velocity)
