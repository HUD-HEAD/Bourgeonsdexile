extends Vehicle

@export var desert_controller: DesertController 
var was_last_puzzle_desert: bool = false


func _on_area_entered(area : Area2D):
	if area is DesertArea:
		was_last_puzzle_desert = true
	
	_stop_walking()
	InputManager.show_mouse()

func _start_walking():
	if was_last_puzzle_desert:
		was_last_puzzle_desert = false
		desert_controller.on_bus_start()
	
	walking = true
	visuals.process_mode = Node.PROCESS_MODE_INHERIT

func _stop_walking():
	walking = false
	
	if was_last_puzzle_desert:
		desert_controller.on_bus_stop(move_speed)
	else:
		#HACK stop wheels + vert sine
		visuals.process_mode = Node.PROCESS_MODE_DISABLED
