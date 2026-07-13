class_name PlayChapterButton  extends TextureButton

@export_file("*.tscn") var chapter_scene : String
@export var chapter_index: int

func _ready() -> void:
	pressed.connect(_on_pressed)
	
func lock_button():
	if !SaveManager.is_chapter_unlock(chapter_index):
		disabled = true
		hide()
	else :
		disabled = false
		show()


## Start game
func _on_pressed():
	AudioManager.audio_sfx.play()
	#SceneManager.goto_scene(chapter_scene)
	
	SaveManager.load_game(chapter_index)
