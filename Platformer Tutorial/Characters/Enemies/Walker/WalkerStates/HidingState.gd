extends State

@export var actor: Walker
@export var animator: AnimatedSprite2D

@onready var look_for_player_raycast = $"../../LookForPlayerRaycast"

signal lost_player
var starting_animator_position
var slowdown_rate = 2
func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	starting_animator_position = actor.global_position
	set_physics_process(true)
	
func _exit_state() -> void:
	set_physics_process(false)
	
func _physics_process(delta):
	animator.play('Hide')
	handle_lost_player()
	
func handle_lost_player():
	if not look_for_player_raycast.is_colliding():
		lost_player.emit()

