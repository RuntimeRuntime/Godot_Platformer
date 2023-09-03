class_name Player
extends CharacterBody2D


const GRAVITY_ACCELERATION = 30
const MAX_GRAVITY = 400.0
const JUMP_POWER = -400
const MAX_JUMPS = 2

var currentDashes = 1
var currentJumps = 2


@onready var sprite = $AnimatedSprite2D
@onready var finite_state_machine = $FiniteStateMachine as FiniteStateMachine
@onready var airborne_state = $FiniteStateMachine/AirborneState as AirborneState
@onready var running_state = $FiniteStateMachine/RunningState as RunningState
@onready var idle_state = $FiniteStateMachine/IdleState as IdleState
@onready var dash_state = $FiniteStateMachine/DashState as DashState



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
