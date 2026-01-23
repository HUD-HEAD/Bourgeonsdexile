extends Clickable

@export var nodes_to_show : Array[Node2D]

var idx = 0

func _ready() -> void:
	for node in nodes_to_show:
		node.hide()
	super()

func _action_on_click():
	if idx < nodes_to_show.size():
		nodes_to_show[idx].show()
		idx += 1
		
	if idx >= nodes_to_show.size():
		disable()
	
	super()
