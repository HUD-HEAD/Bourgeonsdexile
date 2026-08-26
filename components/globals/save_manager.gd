extends Node

var checkpoints_config: CheckpointConfiguration
var actual_save_file: SaveFile
var last_checkpoint :CheckpointData

#Only is true when the build is Museum Type in Build Handler Node on MainMenu scene
var all_chapters_unlock_museum_build_type: bool
var chapter_enable_museum_build_type: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	checkpoints_config = preload("res://components/utils/save_system/save_system_configurations/checkpoints_configuration.tres")
	actual_save_file = SaveFile.load_save_file()

# ── Load Game ───────────────────────────────────
func load_game(chapter: int):
	var checkpoint = CheckpointData.new(chapter)
	match chapter:
		0:
			checkpoint.comic = actual_save_file.chapter_1_last_comic
			checkpoint.panel = actual_save_file.chapter_1_last_panel
		1:
			checkpoint.comic = actual_save_file.chapter_2_last_comic
			checkpoint.panel = actual_save_file.chapter_2_last_panel
		2:
			checkpoint.comic = actual_save_file.chapter_3_last_comic
			checkpoint.panel = actual_save_file.chapter_3_last_panel
	
	_load_last_checkpoint(checkpoint)

func _load_last_checkpoint(data :CheckpointData):
	last_checkpoint = data
	SceneManager.goto_scene(checkpoints_config.get_scene_path(data.comic))

func debug_load_checkpoint():
	#load_game(debug_checkpoint)
	SceneManager.goto_scene(checkpoints_config.get_scene_path(checkpoints_config.debug_checkpoint))

# ── Save Progress ───────────────────────────────────
func save_last_checkpoint(chapter: int, comic: CheckpointConfiguration.comic_types, panel: int):
	last_checkpoint = CheckpointData.new(chapter)
	last_checkpoint.comic = comic
	last_checkpoint.panel = panel
	
	match chapter:
		0:
			actual_save_file.chapter_1_last_comic = comic as int
			actual_save_file.chapter_1_last_panel = panel
			
		1:
			actual_save_file.chapter_2_last_comic = comic as int
			actual_save_file.chapter_2_last_panel = panel
			
		2:
			actual_save_file.chapter_3_last_comic = comic as int
			actual_save_file.chapter_3_last_panel = panel
	
	#update save file
	_save()

# ── Unlock Chapters ───────────────────────────────────
func is_chapter_unlock(chapter_id: int) -> bool:
	if all_chapters_unlock_museum_build_type:
		if chapter_enable_museum_build_type == chapter_id:
			return true
		else:
			return false 
	if checkpoints_config.lock_chapters:
		return actual_save_file.chapter_unlock >= chapter_id
	
	return true

func unlock_chapter(chapter_id: int = -1):
	if chapter_id == -1:
		chapter_id = last_checkpoint.chapter
	else:
		last_checkpoint = CheckpointData.new(chapter_id)
	
	if chapter_id + 1 >= actual_save_file.chapter_unlock:
		actual_save_file.chapter_unlock = chapter_id + 1
		_save()
		update_menu_buttons()
	
	reset_current_chapter()

# ── Menu ───────────────────────────────────
func update_menu_buttons():
	#Calls menu component to update each button
	if get_tree().root.has_node("MainMenu"):
		var main_menu_reference: MainMenu = get_tree().root.get_node("MainMenu") as MainMenu 
		if main_menu_reference:
			main_menu_reference.update_chapter_buttons() 
	else:
		await get_tree().create_timer(0.5).timeout
		if get_tree().root.has_node("MainMenu"):
			var main_menu_reference: MainMenu = get_tree().root.get_node("MainMenu") as MainMenu 
			if main_menu_reference:
				main_menu_reference.update_chapter_buttons() 

# ── Save file funcs ───────────────────────────────────
func reset_save_file():
	actual_save_file = SaveFile.reset_save_file()
	update_menu_buttons()

func reset_current_chapter():
	match last_checkpoint.chapter:
		0:
			actual_save_file.chapter_1_last_comic = 0
			actual_save_file.chapter_1_last_panel = 0
		1:
			actual_save_file.chapter_2_last_comic = 7
			actual_save_file.chapter_2_last_panel = 0
		2:
			actual_save_file.chapter_3_last_comic = 14
			actual_save_file.chapter_3_last_panel = 0
	
	_save()

func _save():
	actual_save_file.save()
