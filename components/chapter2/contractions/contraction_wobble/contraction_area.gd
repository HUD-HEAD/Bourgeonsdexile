extends Area2D

@export var shader_params : Array[ShaderParam]
@export var woman : Woman

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func _on_area_entered(_area : Area2D):
	SignalManager.trigger_contraction.emit(shader_params)
	woman.anim_sprite.play("idle_tired")
	
func _on_area_exited(_area : Area2D):
	pass
