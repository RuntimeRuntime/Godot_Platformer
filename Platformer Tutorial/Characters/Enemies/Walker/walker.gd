class_name Walker
extends CharacterBody2D

@onready var fns = $FiniteStateMachine
@onready var walking_state = $FiniteStateMachine/WalkingState
@onready var hiding_state = $FiniteStateMachine/HidingState

@onready var starting_position = global_position

func _ready():
	
	walking_state.found_player.connect(fns.change_state.bind(hiding_state))
	
	hiding_state.lost_player.connect(fns.change_state.bind(walking_state))
	
