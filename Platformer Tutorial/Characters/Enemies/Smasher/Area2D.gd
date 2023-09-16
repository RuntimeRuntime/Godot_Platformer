extends Area2D

signal isGrounded

func _on_body_entered(body):
	if body is TileMap:
		isGrounded.emit()
