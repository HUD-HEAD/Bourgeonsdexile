extends Woman
@export var model : Woman

func _ready() -> void:
	model.char_area.area_entered.connect(_stop_walking.unbind(1))
	SignalManager.obstacle_cleared.connect(_start_walking)
	_start_walking()
	
	if path_follow != null:
		walk_along_path = true
