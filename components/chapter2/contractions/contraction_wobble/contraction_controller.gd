class_name ContractionController extends Node

@export var shader_mat : ShaderMaterial
@export var shader_params : Array[ShaderParam]

@export var contraction_overlay : CanvasItem

const SOOTHE_ACCELERATOR : float = 2

func _ready() -> void:
	SignalManager.trigger_contraction.connect(trigger_contraction)
	for sp in shader_params:
		shader_mat.set_shader_parameter(sp.name, sp.curr_val)

func _process(delta: float) -> void:
	if Input.is_action_pressed("select_element"):
		self.soothe_contraction(delta*0.1)
		
		if self._check_soothed() :
			#HACK
			process_mode = Node.PROCESS_MODE_DISABLED
			self.stop_contraction()
			SignalManager.next_panel.emit()
			#HACK
			SignalManager.obstacle_cleared.emit()
			
			AudioManager.stop_last_sfx_saved()

#TODO need to fix in shader Speed adjustment looing like "rewind"
func soothe_contraction(delta):
	for sp in shader_params:
		var new_val = move_toward(sp.curr_val, sp.min_val, delta*(sp.max_val-sp.min_val)*SOOTHE_ACCELERATOR)
		shader_mat.set_shader_parameter(sp.name, new_val)
		sp.curr_val = new_val

func _check_soothed() -> bool:
	for sp in shader_params:
		if sp.curr_val <= sp.min_val:
			return true
	return false

func trigger_contraction(_shader_params : Array[ShaderParam]):
	if _shader_params.size() == shader_params.size():
		shader_params = _shader_params
	
	for sp in shader_params:
		shader_mat.set_shader_parameter(sp.name, sp.max_val)
		sp.curr_val = sp.max_val
	
	var tween_modulate : Tween = get_tree().create_tween()
	tween_modulate.tween_property(contraction_overlay, "modulate:a", 1.0, 3.0)
	process_mode = Node.PROCESS_MODE_INHERIT
	
	#HACK TODO Maybe replace with control overlay activating
	SignalManager.set_cursor_shape.emit(Input.CURSOR_POINTING_HAND)
	
func stop_contraction():
	var tween_modulate : Tween = get_tree().create_tween()
	tween_modulate.tween_property(contraction_overlay, "modulate:a", 0.0, 3.0)

	#HACK TODO Maybe replace with control overlay disappearing
	SignalManager.set_cursor_shape.emit(Input.CURSOR_POINTING_HAND)
	

	
