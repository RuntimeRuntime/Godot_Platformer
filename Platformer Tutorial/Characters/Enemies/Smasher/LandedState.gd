extends State

@export var animator: AnimatedSprite2D
@onready var timer = $"../../GroundedTimer"
@onready var particles = $"../../GPUParticles2D"
@onready var hitbox = $"../../Hitbox/KillBox"

signal is_rising

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	call_deferred('disable_hitbox')
	timer.start()
	particles.emitting=true
	set_physics_process(true)
	
func _exit_state() -> void:
	set_physics_process(false)
	
func _physics_process(delta):
	animator.play('Idle')


func _on_grounded_timer_timeout():
	is_rising.emit()

func disable_hitbox():
	hitbox.set_disabled(true)
