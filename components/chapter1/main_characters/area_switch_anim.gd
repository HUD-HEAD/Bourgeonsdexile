extends Area2D

@export var anim_name : String

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area2d : Area2D):
	var woman : Woman = area2d.get_parent()
	woman.switch_animation(anim_name)
