extends Node
@onready var woman : Woman = get_parent()
var prev_pos : Vector2

func _ready() -> void:
	prev_pos = woman.global_position

func _process(_delta):
	_face_path()

#TODO move out / rename node
func _face_path():
	woman.anim_sprite.flip_h = woman.global_position.x < prev_pos.x
	prev_pos = woman.global_position
