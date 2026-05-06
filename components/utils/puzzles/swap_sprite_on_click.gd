extends Sprite2D

#TODO HACK cleanup

@export var clickable : Clickable
@export var old_sprite : Sprite2D

func _ready() -> void:
	if is_instance_valid(texture) :
		clickable.clicked.connect(_on_clickable_clicked)
	else :
		queue_free()
	
func _on_clickable_clicked():
	old_sprite.hide()
	self.show()
