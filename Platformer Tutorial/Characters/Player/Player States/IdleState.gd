class_name IdleState
extends State

@export var actor: Player
@export var animator: AnimatedSprite2D

signal is_jumping
signal is_running

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	print('Idle')
	set_physics_process(true)
	actor.currentJumps = actor.MAX_JUMPS
	
func _exit_state() -> void:
	set_physics_process(false)
	
func _physics_process(delta):
	animator.play('Idle')
	var input_dir = UtilityMovementMethods.input_direction(animator)
	actor.velocity.x = UtilityMovementMethods.calculate_velocity_x(input_dir.x, actor.velocity.x)
	CheckStateChange.check_is_jumping(is_jumping, actor)
	CheckStateChange.check_is_running(is_running, input_dir.x)
	CheckStateChange.check_is_falling(is_jumping, actor)
