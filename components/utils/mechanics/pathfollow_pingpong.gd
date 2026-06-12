extends Node
@export var char : Woman
var prev_pos : Vector2

func _ready() -> void:
	prev_pos = char.global_position

func _process(_delta):
	if char.path_follow.progress_ratio == 0 || char.path_follow.progress_ratio == 1:
		char.dir *= -1
		
	if char.global_position.x < prev_pos.x :
		char.anim_sprite.flip_h = true
	else :
		char.anim_sprite.flip_h = false
	prev_pos = char.global_position
