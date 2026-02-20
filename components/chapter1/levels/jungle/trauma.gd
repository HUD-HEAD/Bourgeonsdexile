extends Node2D

@export var puzzle : DragDropPuzzle
@export var anim_destruction : AnimatedSprite2D
@export var anim_trauma : AnimationPlayer

func _ready() -> void:
	puzzle.puzzle_complete.connect(_on_puzzle_complete)
	anim_destruction.hide()

func _on_puzzle_complete():
	anim_destruction.show()
	anim_trauma.play("trauma")
