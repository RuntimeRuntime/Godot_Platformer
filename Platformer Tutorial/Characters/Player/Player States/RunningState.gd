class_name RunningState
extends State

@export var actor: Player
@export var animator: AnimatedSprite2D

signal is_jumping
signal is_idle

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	print('Running')
	set_physics_process(true)
	actor.currentJumps = actor.MAX_JUMPS
	UtilityMovementMethods.canDash = true
	
func _exit_state() -> void:
	set_physics_process(false)
	
func _physics_process(delta):
	animator.play('Run')
	var input_dir = UtilityMovementMethods.input_direction(animator)
	actor.velocity.x = UtilityMovementMethods.calculate_velocity_x(input_dir.x, actor.velocity.x)
	check_for_state_change(input_dir)

func check_for_state_change(input_dir) -> void:
	CheckStateChange.check_is_jumping(is_jumping, actor)
	CheckStateChange.check_is_idle(is_idle, input_dir.x)
	CheckStateChange.check_is_falling(is_jumping, actor)

func calculate_jump_velocity():
	actor.velocity.y = actor.JUMP_POWER
	actor.currentJumps -= 1
