extends CanvasLayer

@export_group("Buttons")
@export var play : Button
@export var settings : Button
@export var credits : Button
@export var quit : Button

const start_scene = "res://levels/jungle/jungle_comic_1.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	_buttons_connect()

func _buttons_connect():
	play.pressed.connect(_on_play_pressed)
	settings.pressed.connect(_on_settings_pressed)
	credits.pressed.connect(_on_credits_pressed)
	quit.pressed.connect(_on_quit_pressed)

## Start game
func _on_play_pressed():
	SceneManager.goto_scene(start_scene)

## Open settings
func _on_settings_pressed():
	pass

## Quit game
func _on_quit_pressed():
	SceneManager.quit_game()

## Open credits
func _on_credits_pressed():
	pass
