extends RemoteTransform2D


@onready var player = $".."
func _physics_process(delta):
	print(player.finite_state_machine.get_current_state())

	if('DeathState' in str(player.finite_state_machine.get_current_state())):
		queue_free()
