extends Area2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	
func _on_area_entered(area : Area2D):
	print("entered receptacle!")
	modulate = Color.AQUA
	
func _on_area_exited(area : Area2D):
	print("exited receptacle!")
	modulate = Color.WHITE
