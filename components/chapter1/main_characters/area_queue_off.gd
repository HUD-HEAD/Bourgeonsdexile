extends Area2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area : Area2D):
	var companion : Companion = area.get_parent()
	companion.model.char_area.area_entered.disconnect(companion._stop_walking)
