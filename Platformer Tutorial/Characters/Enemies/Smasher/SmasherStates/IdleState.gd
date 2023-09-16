extends State

@export var actor: Smasher
@export var animator: AnimatedSprite2D
@export var raycast: RayCast2D

signal player_found

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	
func _exit_state() -> void:
	set_physics_process(false)
	
func _physics_process(delta):
	animator.play('Idle')
	findPlayer()
	
func findPlayer():
	if raycast.is_colliding():
		player_found.emit()
	
