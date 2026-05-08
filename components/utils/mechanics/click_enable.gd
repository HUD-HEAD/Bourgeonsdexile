extends Clickable

@export var node_to_enable : Node

func _ready() -> void:
	node_to_enable.process_mode = Node.PROCESS_MODE_DISABLED
	super()

func _action_on_click():
	node_to_enable.process_mode = Node.PROCESS_MODE_INHERIT
	super()
