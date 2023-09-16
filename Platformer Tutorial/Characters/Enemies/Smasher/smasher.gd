class_name Smasher
extends Node2D


@onready var fns = $FiniteStateMachine
@onready var idle_state = $FiniteStateMachine/IdleState
@onready var shaking_state = $FiniteStateMachine/ShakingState
@onready var falling_state  = $FiniteStateMachine/FallingState
@onready var grounded_state = $FiniteStateMachine/GroundedState
@onready var rise_state = $FiniteStateMachine/RiseState

@onready var starting_position = global_position

func _ready():
	
	idle_state.player_found.connect(fns.change_state.bind(shaking_state))
	
	shaking_state.is_falling.connect(fns.change_state.bind(falling_state))
	
	falling_state.is_grounded.connect(fns.change_state.bind(grounded_state))
	
	grounded_state.is_rising.connect(fns.change_state.bind(rise_state))
	
	rise_state.is_back_at_start_position.connect(fns.change_state.bind(idle_state))
	
func _physics_process(delta):
	pass
