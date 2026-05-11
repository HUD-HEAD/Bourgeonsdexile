extends Node

var puzzle_automatic_positioning : bool = false

# Settings

## Deprecated
# var music_volume : float = 1.0
#var sfx_volume : float = 1.0
#var cursor_size : float = 1.0
#var is_fullscreen : bool = false

var language : String = "EN"

func _ready() -> void:
	SettingsController._initialize()
