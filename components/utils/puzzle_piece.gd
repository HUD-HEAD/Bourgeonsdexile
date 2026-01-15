class_name PuzzlePiece
extends Node2D

signal piece_correctly_placed

@export var draggable : Draggable
@export var placement_checker : PlacementChecker

func _ready() -> void:
	draggable.dropped.connect(_on_piece_dropped)
	
func deactivate():
	draggable.hide()
	draggable.process_mode = Node.PROCESS_MODE_DISABLED	

func _on_piece_dropped():
	if placement_checker.is_correctly_placed():
		piece_correctly_placed.emit()
		print_debug("puzzle piece correct!")

##Assigned in drag_drop_puzzle script
func set_receptacle(receptacle : Area2D):
	placement_checker.receptacle = receptacle

func is_correctly_placed():
	return placement_checker.is_correctly_placed()

func activate_piece(gpos : Vector2):
	draggable.global_position = gpos
	draggable.process_mode = Node.PROCESS_MODE_INHERIT
	draggable.show()
