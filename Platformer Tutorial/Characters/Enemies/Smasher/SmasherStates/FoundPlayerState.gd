extends State

@export var actor: Smasher
@export var animator: AnimatedSprite2D

@onready var fall_timer = $"../../FallTimer"

signal is_falling

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	fall_timer.start(.3)
	set_physics_process(true)
	
func _exit_state() -> void:
	fall_timer.stop()
	actor.position = actor.starting_position
	set_physics_process(false)
	
func _physics_process(delta):
	animator.play('Angry')
	shake_animation(delta)
	
func shake_animation(delta):
	if(actor.position == actor.starting_position):
		actor.position.x += randi_range(-2,2)
		actor.position.y += randi_range(-2,2)
	else: 
		actor.position = actor.starting_position

func _on_timer_timeout():
	is_falling.emit()
