class_name SaveFile extends Resource

@export var chapter_unlock: int = 0

@export var chapter_1_last_comic: int = 0
@export var chapter_1_last_panel: int = 0

@export var chapter_2_last_comic: int = 7
@export var chapter_2_last_panel: int = 0

@export var chapter_3_last_comic: int = 14
@export var chapter_3_last_panel: int = 0

func save() -> void:
	ResourceSaver.save(self, "user://save_file.tres")
	
static func load_save_file() -> SaveFile:
	var save_fi: SaveFile = load("user://save_file.tres") as SaveFile
	
	if !save_fi:
		save_fi = SaveFile.new()
		save_fi.save()
	
	return save_fi
  
static func reset_save_file() -> SaveFile:
	var save_fi: SaveFile = SaveFile.new()
	save_fi.save()
	return save_fi
