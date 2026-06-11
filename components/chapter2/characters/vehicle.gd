#TODO cleanup/refactor with other movement

extends Node2D

@export var char_area : Area2D

@export var move_speed : float = 75
var actual_move_speed : float

@export var visuals : Node2D

var walking : bool

@export_group("Desert")
@export var is_desert_bus: bool = false
@export var desert_controller: DesertController 
var was_last_puzzle_desert: bool = false

#TODO cleanup. Should we set a path on all scenes? 
var walk_along_path = false

func _ready() -> void:
	actual_move_speed = move_speed
	char_area.area_entered.connect(_on_area_entered)
	SignalManager.obstacle_cleared.connect(_start_walking)
	_start_walking()


func _process(delta: float) -> void:
	if walking:
		self.global_position.x += actual_move_speed * delta


func _on_area_entered(area : Area2D):
	if is_desert_bus && area is DesertArea:
		was_last_puzzle_desert = true
	
	_stop_walking()
	InputManager.show_mouse()

	
func _start_walking():
	if is_desert_bus && was_last_puzzle_desert:
		was_last_puzzle_desert = false
		desert_controller.on_bus_start()
	
	walking = true
	visuals.process_mode = Node.PROCESS_MODE_INHERIT

func _stop_walking():
	walking = false
	
	if is_desert_bus && was_last_puzzle_desert:
		desert_controller.on_bus_stop(move_speed)
	else:
		#HACK stop wheels + vert sine
		visuals.process_mode = Node.PROCESS_MODE_DISABLED
	
