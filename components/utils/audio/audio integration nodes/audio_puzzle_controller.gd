class_name PuzzleDecoratorController
extends Node

@onready var puzzle : DragDropPuzzle = get_parent()

@export_category("Sound")
@export var trigger_loop: bool
@export var loop_name: AudioConfiguration.loop_type

func _ready() -> void:
	assert(is_instance_valid(puzzle))
	puzzle.puzzle_spawn.connect(_on_puzzle_spawn)
	puzzle.puzzle_complete.connect(_on_puzzle_complete)

func _on_puzzle_spawn():
	if trigger_loop:
		AudioManager.play_loop(loop_name)

func _on_puzzle_complete():
	if trigger_loop:
		AudioManager.stop_loop(loop_name)
