## A full puzzle set, where each puzzle piece fits in a receptacle
@tool
class_name DragDropPuzzle
extends Node2D

signal puzzle_complete

## All puzzle pieces and their corresponding receptacle
@export var puzzle_pieces : Array[PuzzlePiece]:
	set(_puzzle_pieces):
		puzzle_pieces = _puzzle_pieces
		update_configuration_warnings()
@export var complete_image : Sprite2D
@export var outline_image : Sprite2D

@export_group("Sound")
@export var play_correct_piece: bool = true 
@export var correct_piece_sfx: AudioConfiguration.sfx_type = AudioConfiguration.sfx_type.puzzle_correct_piece
@export var correct_piece_stream: AudioStream
@export var stream_volume: float = 1
@export var min_pitch_stream: float = 1
@export var max_pitch_stream: float = 1

@export var play_resolve_puzzle: bool = true 
@export var resolve_puzzle_sfx: AudioConfiguration.sfx_type = AudioConfiguration.sfx_type.resolve_puzzle
@export var resolve_puzzle_stream: AudioStream

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	if complete_image:
		complete_image.hide()
	# Associate each puzzle piece with its receptacle
	for piece in puzzle_pieces:
		piece.piece_correctly_placed.connect(_on_correct_piece)


## Every time a puzzle piece is correctly placed, check if puzzle is completed
func _on_correct_piece():
	if play_correct_piece:
		if correct_piece_stream != null:
			AudioManager.play_audio_stream(correct_piece_stream, stream_volume, min_pitch_stream, max_pitch_stream)
		else:
			AudioManager.play_sfx(correct_piece_sfx)
	
	if _check_complete():
		_complete_puzzle()

## When puzzle is complete, disable interaction
func _complete_puzzle():
	print_debug("puzzle complete")
	for piece in puzzle_pieces:
		piece.deactivate()
	
	if complete_image :
		complete_image.show()
	if outline_image :
		outline_image.hide()
	
	#HACK
	SignalManager.obstacle_cleared.emit()
	SignalManager.show_next_button.emit()
	puzzle_complete.emit()
	
	if play_resolve_puzzle:
		if resolve_puzzle_stream != null:
			AudioManager.play_audio_stream(resolve_puzzle_stream, stream_volume, min_pitch_stream, max_pitch_stream)
		else:
			AudioManager.play_sfx(resolve_puzzle_sfx)


## Check if all puzzle pieces in puzzle are in the correct place
func _check_complete() -> bool:
	for piece in puzzle_pieces:
		if !piece.is_correctly_placed():
			return false
	
	return true

#region tooling
func _init() -> void:
	update_configuration_warnings()
	
func _get_configuration_warnings():
	var warnings = []

	if puzzle_pieces.size() == 0:
		warnings.append("No puzzle piece assigned.")
	else:
		for puzzle_piece in puzzle_pieces:
			if puzzle_piece == null:
				warnings.append("Assigned puzzle piece is null.")

	return warnings
#endregion
