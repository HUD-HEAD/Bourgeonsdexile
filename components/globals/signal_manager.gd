##Holds global signals
extends Node

#Temporarily ignore warnings for unused signals in this file, as they are connected in other scripts
@warning_ignore_start("unused_signal")

## Demand cursor shape change when interacting with elements
signal set_cursor_shape(shape_idx : int)

## Clearing obstacle in gameplay sections 
signal obstacle_cleared

## Demand next panel in comic section
signal next_panel

## Emitted from various nodes, received by ContractionController
signal trigger_contraction(shader_params : Array[ShaderParam])

@warning_ignore_restore("unused_signal")


func _ready():
	#Trigger transition automatically
	#next_panel.connect(_on_next_panel)
	pass

func _on_next_panel():
	print_debug("next panel")
