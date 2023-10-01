extends Area2D

signal killed_player

func _on_body_entered(body):
	if body is Player: 
		body.player_death()

