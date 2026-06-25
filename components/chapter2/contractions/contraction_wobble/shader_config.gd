@tool
class_name ShaderConfig extends Resource

@export var shader : Shader:
	set(_shader):
		shader = _shader
		_init_params()

@export var shader_params : Dictionary [String, ShaderParam]

func _init_params() -> void:
	if shader == null:
		print_debug("early return")
		return
	
	var uniform_list : Array = shader.get_shader_uniform_list()
	for sp : Dictionary in uniform_list:
		shader_params[sp["name"]] = null
	
	print_debug("init config")
