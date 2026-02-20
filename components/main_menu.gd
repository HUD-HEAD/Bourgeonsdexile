extends CanvasLayer

@export_group("Buttons")
@export var play : BaseButton
@export var settings : BaseButton
@export var credits : BaseButton
@export var quit : BaseButton

@export var audio_click_chapter : AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	_buttons_connect()
	
	AudioManager.audio_sfx.stream = audio_click_chapter

func _buttons_connect():
	play.pressed.connect(_on_play_pressed)
	settings.pressed.connect(_on_settings_pressed)
	credits.pressed.connect(_on_credits_pressed)
	quit.pressed.connect(_on_quit_pressed)

## Start game
func _on_play_pressed():
	AudioManager.audio_sfx.play()
	SceneManager.goto_scene(SceneManager.START_SCENE)
	

## Open settings
func _on_settings_pressed():
	pass

## Quit game
func _on_quit_pressed():
	SceneManager.quit_game()

## Open credits
func _on_credits_pressed():
	pass
