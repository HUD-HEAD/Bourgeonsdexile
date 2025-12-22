extends Node

@export var obstacles_to_clear : int = 0
@export var transition_delay : float = 1.0
var counter : int = 0

func _ready() -> void:
	SignalManager.obstacle_cleared.connect(_on_obstacle_cleared)

func _on_obstacle_cleared():
	counter += 1
	if counter >= obstacles_to_clear:
		InputManager.hide_mouse()
		
		#TASK refactor to centralize delay transition?
		#Delay transition
		await get_tree().create_timer(transition_delay).timeout
		SignalManager.next_panel.emit()
