extends Clickable

@export var switch_sprite : Sprite2D

func _action_on_click():
	switch_sprite.visible = !switch_sprite.visible
	
	SignalManager.obstacle_cleared.emit()
	
