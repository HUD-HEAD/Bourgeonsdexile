extends Node2D

var min : float = 0.2
var max : float = 0.6

@export var color_rect : ColorRect
var shader_mat : ShaderMaterial

func _ready() -> void:
	shader_mat = color_rect.material


func _process(delta: float) -> void:
	var curr_value : float = shader_mat.get_shader_parameter("blur_inner")
	shader_mat.set_shader_parameter("blur_inner", curr_value-delta*1.0)
