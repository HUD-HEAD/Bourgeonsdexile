class_name ChapterEnder
extends Node

enum chapter{
	chapter_1,
	chapter_2,
	chapter_3,
} 

@export var chapter_index: chapter
@onready var transition_scene: PackedScene = preload("res://scenes/menus/chapter_transition.tscn")
@onready var transition_scene_2: PackedScene = preload("res://scenes/menus/chapter_2_transition.tscn")
var transition_scene_instance: CanvasLayer

func trigger_scene_transition():
	SaveManager.unlock_chapter()
	
	if chapter_index==chapter.chapter_2:
		transition_scene_instance = transition_scene_2.instantiate()
	else :
		transition_scene_instance = transition_scene.instantiate()
	
	GameManager.add_child(transition_scene_instance)
