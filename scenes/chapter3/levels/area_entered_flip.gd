extends Node

@export var area2d: Area2D
@export var woman : Woman

func _ready() -> void:
	area2d.area_entered.connect(_on_area_entered)
	
func _on_area_entered(area2d):
	woman.anim_sprite.flip_h = !woman.anim_sprite.flip_h
