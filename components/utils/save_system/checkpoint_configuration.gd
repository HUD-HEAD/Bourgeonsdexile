class_name CheckpointConfiguration extends Resource



#class checkpoint_scene_configuration:
	##@export var  comic: comic_types
	##@export_file("*.tscn") var chapter_scene : String
	#var  comic: comic_types
	#var chapter_scene : String

func get_scene_path(type: comic_types) -> String:
	return scene_configuration[type]

@export_group("Debug")
@export var debug_checkpoint: comic_types

@export_group("Configuration")
@export var lock_chapters: bool = true
@export var scene_configuration: Dictionary = {
	comic_types.chapter_1_comic_1:"res://scenes/chapter1/chapter1_videoplayer.tscn",
	comic_types.chapter_1_comic_2:"res://scenes/chapter1/comics/jungle_comic_2.tscn",
	comic_types.chapter_1_comic_3:"res://scenes/chapter1/comics/jungle_comic_3.tscn",
	comic_types.chapter_1_comic_4:"res://scenes/chapter1/comics/jungle_comic_4.tscn",
	comic_types.chapter_1_puzzle_1:"res://scenes/chapter1/levels/jungle_city.tscn",
	comic_types.chapter_1_puzzle_2:"res://scenes/chapter1/levels/jungle.tscn",
	comic_types.chapter_1_puzzle_3:"res://scenes/chapter1/levels/lajas_blancas.tscn",
	comic_types.chapter_2_comic_1:"res://scenes/chapter2/chapter2_videoplayer.tscn",
	comic_types.chapter_2_comic_2:"res://scenes/chapter2/comics/chapter2_comic_2.tscn",
	comic_types.chapter_2_comic_3:"res://scenes/chapter2/comics/chapter2_comic_3.tscn",
	comic_types.chapter_2_comic_4:"res://scenes/chapter2/comics/chapter2_comic_4.tscn",
	comic_types.chapter_2_puzzle_1:"res://scenes/chapter2/levels/goma.tscn",
	comic_types.chapter_2_puzzle_2:"res://scenes/chapter2/levels/desert.tscn",
	comic_types.chapter_2_puzzle_3:"res://scenes/chapter2/levels/nakivale.tscn",
	comic_types.chapter_3_comic_1:"res://scenes/chapter3/comics/gnv_comic_1.tscn",
	comic_types.chapter_3_comic_2:"res://scenes/chapter3/comics/gnv_comic_2.tscn",
	comic_types.chapter_3_comic_3:"res://scenes/chapter3/comics/gnv_comic_3.tscn",
	comic_types.chapter_3_comic_4:"res://scenes/chapter3/comics/gnv_comic_4.tscn",
	comic_types.chapter_3_puzzle_1:"res://scenes/chapter3/levels/Level3-1.tscn",
	comic_types.chapter_3_puzzle_2:"res://scenes/chapter3/levels/level_2a.tscn",
	comic_types.chapter_3_puzzle_3:"res://scenes/chapter3/levels/Level3-3.tscn",
}


enum comic_types
{
	chapter_1_comic_1,
	chapter_1_comic_2,
	chapter_1_comic_3,
	chapter_1_comic_4,
	chapter_1_puzzle_1,
	chapter_1_puzzle_2,
	chapter_1_puzzle_3,
	
	chapter_2_comic_1,
	chapter_2_comic_2,
	chapter_2_comic_3,
	chapter_2_comic_4,
	chapter_2_puzzle_1,
	chapter_2_puzzle_2,
	chapter_2_puzzle_3,

	chapter_3_comic_1,
	chapter_3_comic_2,
	chapter_3_comic_3,
	chapter_3_comic_4,
	chapter_3_puzzle_1,
	chapter_3_puzzle_2,
	chapter_3_puzzle_3,
}
