extends Node

@export var obstacles_to_clear : int = 0
@export var transition_delay : float = 1.0
var counter : int = 0

func _ready() -> void:
	SignalManager.obstacle_cleared.connect(_on_obstacle_cleared)

func _on_obstacle_cleared():
	#print_debug(owner.process_mode, "	", owner.is_processing())
	#TODO rework counter logic
	#HACK prevent node from processing signal if disabled
	if owner.process_mode == ProcessMode.PROCESS_MODE_DISABLED:
		return
	
	counter += 1
	if counter >= obstacles_to_clear:
		InputManager.hide_mouse()
		
		#TASK refactor to centralize delay transition?
		#Delay transition
		await get_tree().create_timer(transition_delay).timeout
		SignalManager.next_panel.emit()
