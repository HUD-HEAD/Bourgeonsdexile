class_name HidePuzzleOnComplete
extends Node

@onready var puzzle : DragDropPuzzle = get_parent()

@export var transition_enabled: bool = false
@export var extra_elements_to_hide: Array[CanvasItem]
var delay: float = 2
var transition_time: float = 1

func _ready() -> void:
	assert(is_instance_valid(puzzle))
	puzzle.puzzle_complete.connect(_hide_puzzle)

func _hide_puzzle():
	if transition_enabled:
		await get_tree().create_timer(delay).timeout
		var tween = create_tween()
		tween.tween_property(puzzle.complete_image, "modulate:a", 0.0, transition_time)
		await get_tree().create_timer(transition_time).timeout
		puzzle.hide()
		for item: CanvasItem in extra_elements_to_hide:
			item.hide()
	else:
		puzzle.hide()
		for item: CanvasItem in extra_elements_to_hide:
			item.hide()
