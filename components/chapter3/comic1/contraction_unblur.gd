extends Node

@export var shader_mat : ShaderMaterial
@export var contraction_circle : Node2D

var base_value : float

func _ready() -> void:
	base_value = shader_mat.get_shader_parameter("blur_amount")

func _process(delta: float) -> void:
	var progress : float = contraction_circle.compute_progress()
	shader_mat.set_shader_parameter("blur_amount", base_value*(1 - progress))
