class_name TransitionerCounter
extends Node

@export var clickables : Array[Clickable]

@export var obstacles_to_clear : int = -1
@export var transition_delay : float = 1.0
var counter : int = 0

func _ready() -> void:
	if obstacles_to_clear == -1:
		obstacles_to_clear = clickables.size()
	for clickable in clickables:
		clickable.clicked.connect(_on_obstacle_cleared)

func _on_obstacle_cleared():
	#print_debug(owner.process_mode, "	", owner.is_processing())
	#TODO rework counter logic
	#HACK prevent node from processing signal if disabled
	if owner.process_mode == ProcessMode.PROCESS_MODE_DISABLED:
		return
	
	counter += 1
	if counter >= obstacles_to_clear:
		#Disable interaction
		for clickable in clickables:
			clickable.clicked.disconnect(_on_obstacle_cleared)
		
		
		#TASK refactor to centralize delay transition?
		#Delay transition
		await get_tree().create_timer(transition_delay).timeout
		SignalManager.next_panel.emit()
