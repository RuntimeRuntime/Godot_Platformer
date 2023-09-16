class_name CheckStateChange
extends Node

static func check_is_running(isRunningSignal: Signal, runningDirection: int):
	if runningDirection != 0:
		isRunningSignal.emit()

static func check_is_jumping(isJumpingSignal: Signal, actor: CharacterBody2D):
	if(Input.is_action_just_pressed('jump') && actor.currentJumps > 0):
		isJumpingSignal.emit()

static func check_is_falling(isFallingSignal: Signal, actor: CharacterBody2D):
	actor.floor_snap_length = 4
	actor.apply_floor_snap()
	if !actor.is_on_floor():
		isFallingSignal.emit()

static func check_is_grounded(isGroundedSignal: Signal, actor: CharacterBody2D):
	if actor.is_on_floor():
		isGroundedSignal.emit()
		
static func check_is_idle(isIdleSignal: Signal, runningDirection: int):
	if runningDirection == 0:
		isIdleSignal.emit()
		
static func check_is_dashing(isDashingSignal: Signal, actor: CharacterBody2D):
	if Input.is_action_pressed('dash') && UtilityMovementMethods.canDash == true:
		isDashingSignal.emit()
		
