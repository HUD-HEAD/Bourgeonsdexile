extends AnimatedSprite2D

@export var clickable : Clickable

func _ready() -> void:
	clickable.clicked.connect(_action_on_clicked)

func _action_on_clicked():
	frame += 1
