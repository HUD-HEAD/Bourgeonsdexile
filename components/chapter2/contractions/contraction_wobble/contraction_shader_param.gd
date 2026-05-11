class_name ShaderParam extends Resource

@export var name : String
@export var min_val : float
@export var max_val : float
@export var curr_val : float

#func _init(_name : String,  _min_val : float, _max_val : float, _curr_val = _min_val) -> void:
	#name = _name
	#max_val = _max_val
	#min_val = _min_val
	#curr_val = curr_val
