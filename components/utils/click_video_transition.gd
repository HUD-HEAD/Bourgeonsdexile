extends Clickable

@export var target_scene : PackedScene
@export var video_loop : VideoStreamPlayer
@export var video_transition : VideoStreamPlayer

func _ready() -> void:
	super()
	
	video_transition.finished.connect(_on_video_transition_finished)
	video_transition.hide()

func _action_on_click():
	video_transition.play()
	video_transition.show()
	
	video_loop.stop()
	video_loop.hide()
	
	hide()

func _on_video_transition_finished():
	SceneManager.goto_scene(target_scene)
