extends Node

@export var area2d : Area2D
@export var anim_player : AnimationPlayer
@export var anim_name : String = "default"

func _ready() -> void:
	area2d.area_entered.connect(_on_area_entered)
	
func _on_area_entered(_area2d):
	anim_player.play(anim_name)
	
