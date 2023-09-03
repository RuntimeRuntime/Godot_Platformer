class_name AirborneState
extends State

const GRAVITY_ACCELERATION = 30
const MAX_GRAVITY = 400.0
const JUMP_POWER = -400

@export var actor: Player
@export var animator: AnimatedSprite2D

signal is_Dashing
signal is_Grounded

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	print('Airborne')
	set_physics_process(true)
	animator.play('Jump')
	check_is_jumping()
	
func _exit_state() -> void:
	animator.scale = Vector2.ONE
	set_physics_process(false)
	
@warning_ignore("unused_parameter")
func _physics_process(delta):
	# Apply Gravity	
	var input_dir = UtilityMovementMethods.input_direction(animator)
	actor.velocity.x = UtilityMovementMethods.calculate_velocity_x(input_dir.x, actor.velocity.x)
	apply_gravity()
	check_for_input()
	animate_airborne_sprite()

func check_for_input():
	check_is_jumping()
	CheckStateChange.check_is_grounded(is_Grounded, actor)
	CheckStateChange.check_is_dashing(is_Dashing, actor)

func apply_gravity():
	actor.velocity.y = move_toward(actor.velocity.y, MAX_GRAVITY, GRAVITY_ACCELERATION)
	
func check_is_jumping():
	if(Input.is_action_just_pressed('ui_up') && actor.currentJumps > 0):
		handle_jump()

func handle_jump():
	actor.velocity.y = JUMP_POWER
	actor.currentJumps -= 1
	
func animate_airborne_sprite():
	if(actor.velocity.y > 0):
		var stretchY = clamp(actor.velocity.y / 200, 1, 1.3)
		var stretchSize = Vector2(.95, stretchY)
		animator.scale = animator.scale.move_toward(stretchSize, .1)
	else:
		animator.scale = Vector2.ONE
