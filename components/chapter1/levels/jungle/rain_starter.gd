extends VisibleOnScreenNotifier2D

@export var rain : GPUParticles2D

func _ready() -> void:
	screen_exited.connect(_on_screen_entered)
	rain.amount_ratio = 0
	
	
func _on_screen_entered():
	var tween = rain.create_tween()
	tween.tween_property(rain, "amount_ratio", 1.0, 10)
	
