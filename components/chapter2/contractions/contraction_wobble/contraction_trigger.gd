extends VisibleOnScreenNotifier2D

@export var shader_params : Array[ShaderParam]
@export var shader_material : ShaderMaterial

func _ready() -> void:
	screen_entered.connect(_on_screen_entered)

func _on_screen_entered():
	SignalManager.trigger_contraction.emit(shader_params, shader_material)
