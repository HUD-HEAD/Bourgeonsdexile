extends Area2D

@export var shader_params : Array[ShaderParam]
@export var shader_material : ShaderMaterial
@export var woman : Woman

func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(_area : Area2D):
	SignalManager.trigger_contraction.emit(shader_params, shader_material)
	woman.anim_sprite.play("idle_tired")
