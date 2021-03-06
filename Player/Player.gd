extends KinematicBody2D

const ACCELERATION = 610
const FRICTION = 631
const MAX_SPEED = 90 

# -- The current velocity vector for the 'Player'.
var velocity = Vector2.ZERO
# -- The 'AnimationPlayer' responsible for animating the 'Player'.
onready var animation_player = $AnimationPlayer
# -- The 'AnimationTree' responsible for storage of the animations for Player'.
onready var animation_tree = $AnimationTree

func _physics_process(delta):
	var input_v = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	animate(input_v)
	
	if input_v == Vector2.ZERO:
		# Slow down player
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	else:
		# Accelerate
		velocity = velocity.move_toward(input_v * MAX_SPEED, ACCELERATION * delta)

	velocity = move_and_slide(velocity)

# -- Animates the 'Player' sprite depending on current direction.
func animate(input_v: Vector2):
	var animation_state = animation_tree.get("parameters/playback")
	
	if input_v == Vector2.ZERO:
		animation_state.travel("Idle")
	else:
		animation_state.travel("Run")	
		animation_tree.set("parameters/Idle/blend_position", input_v)
		animation_tree.set("parameters/Run/blend_position", input_v)
	
	
