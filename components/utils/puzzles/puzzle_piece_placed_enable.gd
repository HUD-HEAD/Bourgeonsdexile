extends Node

@export var puzzle_piece : PuzzlePiece
@export var node_to_enable : Node

func _ready() -> void:
	node_to_enable.process_mode = Node.PROCESS_MODE_DISABLED
	puzzle_piece.piece_correctly_placed.connect(_action_on_placed)

func _action_on_placed():
	node_to_enable.process_mode = Node.PROCESS_MODE_INHERIT
