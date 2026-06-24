extends Node

@export var puzzle : DragDropPuzzle
@export var anim_player : AnimationPlayer
@export var anim_name : String = "default"

func _ready() -> void:
	puzzle.puzzle_complete.connect(_on_puzzle_complete)
	
func _on_puzzle_complete():
	anim_player.play(anim_name)
