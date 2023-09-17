extends State

@export var actor: Walker
@export var animator: AnimatedSprite2D

@onready var downward_raycast = $"../../DownwardRaycast"
@onready var look_for_player_raycast = $"../../LookForPlayerRaycast"

signal found_player

var directionModifier = -1

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	
func _exit_state() -> void:
	set_physics_process(false)
	
func _physics_process(delta):
	animator.play('Walk')
	handle_turn_around()
	sprite_direction()
	handle_movement()
	actor.move_and_slide()
	handle_found_player()

func handle_turn_around():
	if not downward_raycast.is_colliding()  || actor.is_on_wall():
		directionModifier *= -1
		downward_raycast.position.x *= -1
		look_for_player_raycast.target_position.x *= -1

func sprite_direction():
	var flip_direction = 1
	if directionModifier == -1:
		flip_direction = 0
	animator.flip_h = flip_direction

func handle_movement():
	actor.velocity.x = 25 * directionModifier
	
func handle_found_player():
	if look_for_player_raycast.is_colliding():
		found_player.emit()

	
	
