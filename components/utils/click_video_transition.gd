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
	var callback = func ():
		get_tree().create_timer(1.0).timeout.connect(SceneManager.goto_scene.bind(target_scene))
		
	
	var tween : Tween = get_tree().create_tween()
	tween.tween_property($"../../TextureRect", "modulate", Color.WHITE, 1.0)
	tween.tween_callback(callback)
	#SceneManager.goto_scene(target_scene)
