class_name Companion extends Woman
#TODO refactor/cleanup 

@export var model : Woman
@export var offset_from_model : float = 0

func _ready() -> void:
	model.char_area.area_entered.connect(_stop_walking.unbind(1))
	SignalManager.obstacle_cleared.connect(_start_walking)
	_start_walking()
	
	if path_follow != null:
		walk_along_path = true
		offset_from_model = self.path_follow.progress - model.path_follow.progress
	else:
		offset_from_model = self.global_position.x - model.global_position.x

func disable():
	hide()
	queue_free()
