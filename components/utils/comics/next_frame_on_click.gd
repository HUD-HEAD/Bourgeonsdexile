extends AnimatedSprite2D

@export var clickable : Clickable

func _ready() -> void:
	clickable.clicked.connect(_action_on_clicked)

##Go to next frame. If reached end of animation, disable clickable
func _action_on_clicked():
	frame += 1
	if frame >= sprite_frames.get_frame_count("default") - 1:
		clickable.disable()
