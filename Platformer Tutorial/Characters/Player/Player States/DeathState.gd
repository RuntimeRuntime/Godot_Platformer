class_name DeathState
extends State
const GRAVITY_ACCELERATION = 30
const MAX_GRAVITY = 400.0

@export var actor: Player
@export var animator: AnimatedSprite2D

@onready var collision_shape = $"../../CollisionShape2D"
signal is_jumping
signal is_running

var death_velocity = Vector2(randi_range(-400, 400), -500)

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	actor.velocity = death_velocity
	set_physics_process(true)
	
func _exit_state() -> void:
	set_physics_process(false)
	
func _physics_process(delta):
	animator.play('Idle')
	handle_death_movement()
	collision_shape.disabled = true

func handle_death_movement():
	animator.rotate(.5)
	handle_gravity()
	
func handle_gravity():
	actor.velocity.y = move_toward(actor.velocity.y, MAX_GRAVITY, GRAVITY_ACCELERATION)

