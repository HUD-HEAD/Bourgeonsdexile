extends Area2D

func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)
	#Ensure correct disable on scene start
	_on_visibility_changed()

func _on_visibility_changed():
	if is_visible_in_tree():
		monitorable = true
		monitoring = true
	else:
		monitorable = false
		monitoring = false
