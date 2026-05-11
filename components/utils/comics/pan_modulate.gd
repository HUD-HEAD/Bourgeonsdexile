extends Node2D

@export var sensitivity : float = 1.0
@export var invert : bool = false

#HACK
@export var node_to_enable : Node


#TODO optimize cursor shape signals

func _ready() -> void:
	self_modulate.a = 0.0 if !invert else 1.0
	
	node_to_enable.process_mode = Node.PROCESS_MODE_DISABLED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && Input.is_action_pressed("select_element"):
		SignalManager.set_cursor_shape.emit(Input.CURSOR_MOVE)
		#Panning to the right only
		if event.relative.x < 0:
			var added_val = event.relative.x*sensitivity
			if invert :
				added_val = -added_val
			self_modulate.a = clampf( self_modulate.a - added_val,0,1)

			if (!invert && self_modulate.a >= 1.0) or (invert && self_modulate.a <= 0.0):
				complete()
				
	else:
		SignalManager.set_cursor_shape.emit(Input.CURSOR_POINTING_HAND)


func complete():
	#HACK
	self.process_mode = Node.PROCESS_MODE_DISABLED
	node_to_enable.process_mode = Node.PROCESS_MODE_INHERIT
	
