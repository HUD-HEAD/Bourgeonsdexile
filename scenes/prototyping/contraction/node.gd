extends Node

@export var shader_mat : ShaderMaterial

@onready var curr_val : float = shader_mat.get_shader_parameter("speed")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("select_element"):
		soothe_contraction(delta)
	
func soothe_contraction(delta):
		#var curr_val = shader_mat.get_shader_parameter("waves")
		#shader_mat.set_shader_parameter("waves", 2)
		#shader_mat.set_shader_parameter("amplitude", 0.1)
		$"../Label".text = str(curr_val)
		var target_val = 0.1
		var new_val = move_toward(curr_val, target_val, delta)
		$"../Label".text += str('\n', new_val)
		shader_mat.set_shader_parameter("speed", new_val)
		curr_val = new_val
