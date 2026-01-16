## A puzzle piece module with components to drag and drop onto a corresponding receptacle
class_name PuzzlePiece
extends Node2D

signal piece_correctly_placed

## Component handling drag and drop
@export var draggable : Draggable
## Component checking if piece is placed in associated receptacle. Should be a child of Draggable
@export var placement_checker : PlacementChecker

func _ready() -> void:
	draggable.dropped.connect(_on_piece_dropped)
	
func deactivate():
	draggable.hide()
	draggable.process_mode = Node.PROCESS_MODE_DISABLED	

## When piece is dropped (placed), emit signal if correctly placed in receptacle
func _on_piece_dropped():
	if placement_checker.is_correctly_placed():
		piece_correctly_placed.emit()
		print_debug("puzzle piece correct!")

## Called from drag_drop_puzzle script to associate puzzle piece with a receptacle
func set_receptacle(receptacle : Area2D):
	placement_checker.receptacle = receptacle

## Check if correctly placed in receptacle
func is_correctly_placed():
	return placement_checker.is_correctly_placed()

## Move puzzle piece to target position and enable interactivity
func activate_piece(gpos : Vector2):
	draggable.global_position = gpos
	draggable.process_mode = Node.PROCESS_MODE_INHERIT
	draggable.show()
