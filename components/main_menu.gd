extends CanvasLayer

@export_group("Buttons")
@export var settings : BaseButton
@export var credits : BaseButton
@export var quit : BaseButton

@export var audio_click_chapter : AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	_buttons_connect()
	
	AudioManager.audio_sfx.stream = audio_click_chapter

func _buttons_connect():
	settings.pressed.connect(_on_settings_pressed)
	credits.pressed.connect(_on_credits_pressed)
	quit.pressed.connect(_on_quit_pressed)

## Open settings
func _on_settings_pressed():
	SceneManager.open_settings()

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		if SceneManager.settings_instance:
			SceneManager.settings_instance._on_close_button_pressed()
		else:
			_on_quit_pressed()

## Quit game
func _on_quit_pressed():
	SceneManager.quit_game()

## Open credits
func _on_credits_pressed():
	pass
