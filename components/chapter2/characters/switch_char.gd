extends Node

@export var puzzle_trigger : DragDropPuzzle
@export var char_to_disable : Node2D
@export var char_to_enable : Node2D
@export var camera_to_reparent : Camera2D

func _ready() -> void:
	char_to_enable.process_mode = Node.PROCESS_MODE_DISABLED
	char_to_enable.hide()
	
	puzzle_trigger.puzzle_complete.connect(_on_puzzle_complete)
	
func _on_puzzle_complete():
	char_to_disable.hide()
	char_to_disable.process_mode = Node.PROCESS_MODE_DISABLED
	camera_to_reparent.reparent(char_to_enable)
	char_to_enable.process_mode = Node.PROCESS_MODE_INHERIT
	char_to_enable.show()
