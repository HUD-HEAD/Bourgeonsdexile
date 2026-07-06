class_name AnimationChanger
extends VisibleOnScreenNotifier2D

@export var women_reference: Array[Woman]
var new_animation_key: String = "limp"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.screen_entered.connect(_change_walking_animation)

func _change_walking_animation():
	for ref: Woman in women_reference:
		ref.walking_key_anim = new_animation_key
		ref._start_walking()
