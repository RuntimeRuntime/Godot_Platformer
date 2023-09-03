class_name DashState
extends State

@export var actor: Player
@export var animator: AnimatedSprite2D
@export var dashTimer: Timer

signal dash_completed

const DASH_DURATION = 0.2
func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	print('Dash')
	set_physics_process(true)
	animator.play('Jump')
	dashTimer.start(DASH_DURATION)
	
func _exit_state() -> void:
	animator.scale = Vector2.ONE
	set_physics_process(false)
	
func _physics_process(delta):
	actor.velocity=UtilityMovementMethods.handle_Dash(animator)



func _on_dash_timer_timeout():
	dashTimer.stop()
	dash_completed.emit()
