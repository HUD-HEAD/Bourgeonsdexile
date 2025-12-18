##Executes pan in/out of comic panels
extends Node

#Sequence of panels
@export var panels : Array [Node2D]
#Index of current panel
var idx : int = 0


func _ready() -> void:
	SignalManager.next_panel.connect(_next_panel)


#TESTING
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_next_panel()

func _next_panel():
	assert(idx < panels.size(), "idx inside panels number")
	_pan_out(panels[idx])

	
##Pans panel outside of screen (left), then triggers pan in of next panel
func _pan_out(panel : Node2D):
	var tween : Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(panel, "global_position", Vector2(-1000, panel.global_position.y), 2.0)
	
	idx += 1
	assert(idx < panels.size(), "idx inside panels number")
	
	#When pan out complete, trigger panning in
	tween.tween_callback(_pan_in.bind(panels[idx]))
	
##Pans panel in center of screen
func _pan_in(panel : Node2D):
	var tween : Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(panel, "global_position", Vector2(960, panel.global_position.y), 2.0)
	
