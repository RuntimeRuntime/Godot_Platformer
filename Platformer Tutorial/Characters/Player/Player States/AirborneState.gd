class_name AirborneState
extends State

const GRAVITY_ACCELERATION = 30
const MAX_GRAVITY = 400.0
const JUMP_POWER = -450
const COYOTE_TIME = .15

@export var actor: Player
@export var animator: AnimatedSprite2D

@onready var coyoteTimer = $"../../CoyoteTimer"

signal is_Dashing
signal is_Grounded

var gravityModifier = 1

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	animator.play('Jump')
	if !check_is_jumping():
		coyoteTimer.start(COYOTE_TIME)
	
func _exit_state() -> void:
	animator.scale = Vector2.ONE
	set_physics_process(false)
	gravityModifier = 1
	
@warning_ignore("unused_parameter")
func _physics_process(delta):
	var input_dir = UtilityMovementMethods.input_direction(animator)
	actor.velocity.x = UtilityMovementMethods.calculate_velocity_x(input_dir.x, actor.velocity.x)
	has_release_jump()
	apply_gravity()
	check_for_input()
	animate_airborne_sprite()

func check_for_input():
	check_is_jumping()
	CheckStateChange.check_is_dashing(is_Dashing, actor)
	CheckStateChange.check_is_grounded(is_Grounded, actor)

func apply_gravity():
	if actor.velocity.y >= 0:
		gravityModifier = 1
	actor.velocity.y = move_toward(actor.velocity.y, MAX_GRAVITY, GRAVITY_ACCELERATION * gravityModifier)
	
func check_is_jumping() -> bool:
	if(Input.is_action_just_pressed('ui_up') && actor.currentJumps > 0):
		handle_jump()
		return true
	return false

func handle_jump():
	actor.velocity.y = JUMP_POWER
	actor.currentJumps -= 1
	gravityModifier = 1

func has_release_jump():
	if Input.is_action_just_released("jump") && actor.velocity.y < -50:
		gravityModifier = 1 + (abs(actor.velocity.y) / MAX_GRAVITY)

	
func animate_airborne_sprite():
	if(actor.velocity.y > 0):
		var stretchY = clamp(actor.velocity.y / 200, 1, 1.3)
		var stretchSize = Vector2(.95, stretchY)
		animator.scale = animator.scale.move_toward(stretchSize, .1)
	else:
		animator.scale = Vector2.ONE

func _on_coyote_timer_timeout():
	if(actor.currentJumps == 2):
		actor.currentJumps = 1
