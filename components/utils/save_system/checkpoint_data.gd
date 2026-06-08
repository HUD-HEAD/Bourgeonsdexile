class_name CheckpointData

var chapter: int = 0
var comic: CheckpointConfiguration.comic_types = CheckpointConfiguration.comic_types.chapter_1_comic_1
var panel: int = 0

func _init(_chapter: int) -> void:
	chapter = _chapter
	
