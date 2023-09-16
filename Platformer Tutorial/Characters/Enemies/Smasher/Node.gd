extends State

@export var actor: Smasher

signal is_back_at_start_position

const MAX_SPEED = 2
const ACCELERATION = .2
var current_speed = 0
func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	
func _exit_state() -> void:
	set_physics_process(false)
	
func _physics_process(delta):
	handle_return_to_start_position()
	is_back_to_start_position()
	
func handle_return_to_start_position():
	current_speed = move_toward(current_speed, MAX_SPEED, ACCELERATION)
	actor.position.y -= current_speed
	
func is_back_to_start_position():
	if actor.global_position <= actor.starting_position:
		actor.position.y = actor.starting_position.y
		is_back_at_start_position.emit()

