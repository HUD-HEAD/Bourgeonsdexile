extends Node
#HACK
#TODO cleanup whole queue logic


@export var queue_spots : Array[Sprite2D]

var spots : int


func _ready() -> void:
	SignalManager.obstacle_cleared.connect(_on_obstacle_cleared)
	spots = queue_spots.size()


func _on_obstacle_cleared():
	#print_debug(process_mode)
	if process_mode == ProcessMode.PROCESS_MODE_DISABLED:
		return
	for i in spots:
		var idx = spots-1-i
		if idx > 0:
			queue_spots[idx].texture = queue_spots[idx-1].texture
		else :
			queue_spots[idx].texture = null
		
