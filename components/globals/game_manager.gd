extends Node

var current_puzzle_spawner : Node

# Settings

## Deprecated
# var music_volume : float = 1.0
#var sfx_volume : float = 1.0
#var cursor_size : float = 1.0
#var is_fullscreen : bool = false

var language : String = "EN"

func _ready() -> void:
	SettingsController._initialize(get_viewport())
