extends AudioStreamPlayer

@export var clickables : Array[Clickable]

func _ready() -> void:
	for clickable in clickables:
		clickable.clicked.connect(_on_clickable_clicked)
		
func _on_clickable_clicked():
	play()
