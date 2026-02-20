extends AnimationPlayer

@export var puzzle : DragDropPuzzle
@export var anim_destruction : AnimatedSprite2D

func _ready() -> void:
	puzzle.puzzle_complete.connect(_on_puzzle_complete)
	anim_destruction.hide()

func _on_puzzle_complete():
	anim_destruction.show()
	play("trauma")
