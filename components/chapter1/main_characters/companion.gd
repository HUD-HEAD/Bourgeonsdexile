class_name Companion extends Woman
#TODO refactor/cleanup 

@export var model : Woman
@export var offset_from_model : float = 0
@export var start_walking : bool = true
@export var follow_model : bool = true

func _ready() -> void:
	model.char_area.area_entered.connect(_stop_walking.unbind(1))
	SignalManager.obstacle_cleared.connect(_start_walking)
	if start_walking:
		_start_walking()
	else :
		_stop_walking()
	
	walk_along_path = path_follow != null
	offset_from_model = _compute_offset()

func _process(delta: float) -> void:
	if follow_model:
		if walking:
			if walk_along_path:
				path_follow.progress = model.path_follow.progress + offset_from_model
			else:
				global_position.x = model.global_position.x + offset_from_model
	else:
		#HACK Could/should instead make separate script for queuing people
		super(delta)

func rejoin_model() -> Signal:
	var time_to_walk : float = (offset_from_model - _compute_offset())/float(WALK_SPEED)
	#print_debug(time_to_walk)
	_start_walking()
	return get_tree().create_timer(time_to_walk).timeout

func _compute_offset() -> float:
	if walk_along_path :
		return self.path_follow.progress - model.path_follow.progress
	else:
		return self.global_position.x - model.global_position.x


func _start_walking():
	if can_process():
		super()

func disable():
	hide()
	queue_free()
