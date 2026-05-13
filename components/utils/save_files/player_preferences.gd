class_name PlayerPreferences extends Resource

@export_range(0, 1, 0.01) var music_volume : float = 1.0
@export_range(0, 1, 0.01) var sfx_volume : float = 1.0
@export_range(0.5, 2, 0.1) var cursor_size : float = 1.0
@export var is_fullscreen : bool = true

func save() -> void:
	ResourceSaver.save(self, "user://player_prefs.tres")
	
static func load_player_preferences() -> PlayerPreferences:
	var pref: PlayerPreferences = load("user://player_prefs.tres") as PlayerPreferences
	
	if !pref:
		pref = PlayerPreferences.new()
	
	return pref  
static func reset_player_preferences() -> PlayerPreferences:
	var pref: PlayerPreferences = PlayerPreferences.new()
	pref.save()
	return pref
