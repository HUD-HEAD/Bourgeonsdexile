extends Node2D

## NOTE, TASK : Could be replaced with script on Brush,
## but need to account for position computation differences

@export var brush : Sprite2D
@export var viewport: SubViewport
var mask: ViewportTexture
@export var container: Node2D

var x_offset: float
var y_offset: float

func _ready() -> void:
	brush.hide()
	set_process(false)
	var parent_node = viewport.get_parent()
	x_offset = parent_node.position.x
	y_offset = parent_node.position.y
	
	
func _process(delta: float) -> void:
	#print(get_global_mouse_position())
	#brush.global_position = get_global_mouse_position()
	
	#First we get the reference of the panel to calculate the offset of the panel
	var scene_ref:Node2D = viewport.get_parent().get_parent()
	var mouse_local = scene_ref.to_local(get_global_mouse_position())
	
	#Revert the offset we have applied to swipe puzzle to be centered
	#mouse_local.x +=960
	#mouse_local.y +=540
	
	mouse_local.x += (x_offset * -1)
	mouse_local.y += (y_offset * -1)
	 
	brush.position = mouse_local


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("select_element"):
		set_process(true)
		brush.show()
	elif event.is_action_released("select_element"):
		brush.hide()
		set_process(false)
		
	
