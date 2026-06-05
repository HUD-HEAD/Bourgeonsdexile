class_name ChapterEnder
extends Node

@onready var transition_scene: PackedScene = preload("res://scenes/menus/scene_transition.tscn")
var transition_scene_instance: CanvasLayer

func trigger_scene_transition():
	SaveManager.unlock_chapter()
	
	transition_scene_instance = transition_scene.instantiate()
	GameManager.add_child(transition_scene_instance)
