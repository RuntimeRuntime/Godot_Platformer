class_name UtilityMovementMethods
extends Node

const FRICTION = 70
const ACCELERATION = 50.0
const SPEED = 200.0

static var dashDirection = 1

static func input_direction(sprite: AnimatedSprite2D) -> Vector2:
	var input_dir = Vector2.ZERO
	input_dir.x = Input.get_axis('ui_left', 'ui_right')
	input_dir = input_dir.normalized()
	flip_sprite(sprite, input_dir)
	return input_dir
	
static func flip_sprite(sprite: AnimatedSprite2D, input_dir) -> void:
		if(input_dir.x != 0):
			if input_dir.x == -1:
				sprite.flip_h = 0
			else:
				sprite.flip_h = 1
			#Player.setDashDirection(input_dir.x)
			dashDirection = input_dir.x

static func calculate_velocity_x(direction: int, velocity: float) -> float:
	if(direction != 0):
		return accelerate(direction, velocity)
	else:
		return add_friction(velocity)
	
static func accelerate(direction, velocity) -> float:
	return move_toward(velocity, SPEED * direction, ACCELERATION)

static func add_friction(velocity) -> float:
	return move_toward(velocity, 0.0, FRICTION)
	
static func handle_Dash(sprite: AnimatedSprite2D) -> Vector2:
	var squashSize = Vector2(1.3, 0.7)
	sprite.scale = sprite.scale.move_toward(squashSize, .2)
	return Vector2(300 * UtilityMovementMethods.dashDirection , 0)
