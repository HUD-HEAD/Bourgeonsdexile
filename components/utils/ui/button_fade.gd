extends TextureButton

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	self_modulate.a = 0.5
	
func _on_mouse_entered():
	self_modulate.a = 1.0

func _on_mouse_exited():
	self_modulate.a = 0.5
