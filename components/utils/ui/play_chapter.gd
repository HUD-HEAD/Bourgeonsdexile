extends TextureButton

@export var chapter_scene : PackedScene

func _ready() -> void:
	pressed.connect(_on_pressed)
	
## Start game
func _on_pressed():
	AudioManager.audio_sfx.play()
	if is_instance_valid(chapter_scene):
		SceneManager.goto_scene(chapter_scene)
