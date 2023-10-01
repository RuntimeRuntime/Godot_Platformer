class_name Player
extends CharacterBody2D

const MAX_JUMPS = 2

var currentDashes = 1
var currentJumps = 2


@onready var sprite = $AnimatedSprite2D
@onready var finite_state_machine = $FiniteStateMachine as FiniteStateMachine
@onready var airborne_state = $FiniteStateMachine/AirborneState as AirborneState
@onready var running_state = $FiniteStateMachine/RunningState as RunningState
@onready var idle_state = $FiniteStateMachine/IdleState as IdleState
@onready var dash_state = $FiniteStateMachine/DashState as DashState
@onready var death_state = $FiniteStateMachine/DeathState as DeathState


func _ready():
	idle_state.is_jumping.connect(finite_state_machine.change_state.bind(airborne_state))
	idle_state.is_running.connect(finite_state_machine.change_state.bind(running_state))
	
	
	airborne_state.is_Grounded.connect(finite_state_machine.change_state.bind(idle_state))
	airborne_state.is_Dashing.connect(finite_state_machine.change_state.bind(dash_state))
	
	running_state.is_idle.connect(finite_state_machine.change_state.bind(idle_state))
	running_state.is_jumping.connect(finite_state_machine.change_state.bind(airborne_state))
	
	dash_state.dash_completed.connect(finite_state_machine.change_state.bind(airborne_state))
	
func _physics_process(delta):
	move_and_slide()
	
func player_death():
	finite_state_machine.change_state(death_state)
