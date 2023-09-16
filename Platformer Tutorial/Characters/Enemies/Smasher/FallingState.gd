extends State

@export var actor: Smasher

const ACCELERATION = .1
const MAX_SPEED = 8

signal is_grounded

var current_speed = 0

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	
func _exit_state() -> void:
	current_speed = 0
	set_physics_process(false)
	
func _physics_process(delta):
	handle_fall()
	
func handle_fall():
	current_speed = move_toward(current_speed, MAX_SPEED, ACCELERATION)
	actor.position.y += current_speed
	
func _on_area_2d_is_grounded():
	is_grounded.emit()
