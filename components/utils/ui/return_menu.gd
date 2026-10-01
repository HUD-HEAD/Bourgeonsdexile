extends Control

@export var close_button : Button

const MIN_ALPHA : float = 0.1
const MAX_ALPHA : float = 1.0

func _ready() -> void:
	close_button.mouse_entered.connect(_on_mouse_entered_button)
	close_button.mouse_exited.connect(_on_mouse_exited_button)
	close_button.pressed.connect(_on_button_pressed)
	close_button.modulate.a = MIN_ALPHA

func _on_mouse_entered_button():
	close_button.modulate.a = MAX_ALPHA

func _on_mouse_exited_button():
	close_button.modulate.a = MIN_ALPHA

func _on_button_pressed():
	PauseController.show_pause_menu()
