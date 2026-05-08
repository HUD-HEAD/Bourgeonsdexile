extends Node2D

@export var sensitivity : float = 1.0

#HACK
@export var node_to_enable : Node


#TODO optimize cursor shape signals

func _ready() -> void:
	self_modulate.a = 0.0
	
	node_to_enable.process_mode = Node.PROCESS_MODE_DISABLED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && Input.is_action_pressed("select_element"):
		SignalManager.set_cursor_shape.emit(Input.CURSOR_MOVE)
		#Panning to the right only
		if event.relative.x < 0:
			self_modulate.a = clampf( self_modulate.a - event.relative.x*sensitivity,0,1)

			if self_modulate.a >= 1.0:
				complete()
				
	else:
		SignalManager.set_cursor_shape.emit(Input.CURSOR_POINTING_HAND)


func complete():
	#HACK
	self.process_mode = Node.PROCESS_MODE_DISABLED
	node_to_enable.process_mode = Node.PROCESS_MODE_INHERIT
	
