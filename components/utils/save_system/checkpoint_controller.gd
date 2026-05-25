class_name CheckpointController extends Node

@export var chapter: int
@export var comic: CheckpointConfiguration.comic_types
var panel: int = 0

func _ready() -> void:
	_save_checkpoint()

# Call when the player finish a chapter
func unlock_chapter():
	SaveManager.unlock_chapter(chapter)

# Updates the save file with the last checkpoint 
func _save_checkpoint():
		SaveManager.save_last_checkpoint(chapter, comic, panel)
