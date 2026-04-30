extends TextureButton

@export_file("*.tscn") var chapter_scene : String

func _ready() -> void:
	pressed.connect(_on_pressed)
	
## Start game
func _on_pressed():
	AudioManager.audio_sfx.play()
	SceneManager.goto_scene(chapter_scene)
