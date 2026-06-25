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
		var param_name : String = sp["name"]
		var new_param : ShaderParam = ShaderParam.new()
		new_param.name = param_name
		shader_params[param_name] = new_param
	
	print_debug("init config")
