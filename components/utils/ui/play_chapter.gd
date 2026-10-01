class_name PlayChapterButton  extends TextureButton

@export_file("*.tscn") var chapter_scene : String
@export var chapter_index: int
@export var one_button_pos : Control

func _ready() -> void:
	if SaveManager.all_chapters_unlock_museum_build_type:
		self.global_position = one_button_pos.global_position
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
