extends Node

@export var shader_mat : ShaderMaterial
@export var shader_params : Array[ShaderParam]

func _ready() -> void:
	for sp in shader_params:
		shader_mat.set_shader_parameter(sp.name, sp.curr_val)

func _process(delta: float) -> void:
	if Input.is_action_pressed("select_element"):
		soothe_contraction(delta*0.1)
	
#TODO need to fix in shader Speed adjustment looing like "rewind"
func soothe_contraction(delta):
		for sp in shader_params:
			var new_val = move_toward(sp.curr_val, sp.min_val, delta)
			shader_mat.set_shader_parameter(sp.name, new_val)
			sp.curr_val = new_val
