extends AnimationPlayer

@export var puzzle : DragDropPuzzle
@export var anim_destruction : AnimatedSprite2D
@export var blackout : TextureRect

func _ready() -> void:
	puzzle.puzzle_complete.connect(_on_puzzle_complete)
	anim_destruction.hide()
	blackout.hide()

func _on_puzzle_complete():
	anim_destruction.show()
	play("trauma")
	
	anim_destruction.animation_finished.connect(blackout.show)
