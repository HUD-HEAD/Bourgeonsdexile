extends Woman
#TODO refactor/cleanup 

@export var model : Woman

func _ready() -> void:
	model.char_area.area_entered.connect(_stop_walking.unbind(1))
	SignalManager.obstacle_cleared.connect(_start_walking)
	_start_walking()
	
	if path_follow != null:
		walk_along_path = true

func _process(delta: float) -> void:
	anim_sprite.animation = model.anim_sprite.animation
	if model.walking :
		if walk_along_path:
			path_follow.progress += WALK_SPEED*delta
		else:
			self.global_position.x += WALK_SPEED*delta
