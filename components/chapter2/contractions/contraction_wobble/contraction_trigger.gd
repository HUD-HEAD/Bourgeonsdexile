extends VisibleOnScreenNotifier2D

@export var contraction_controller : ContractionController


func _ready() -> void:
	screen_entered.connect(_on_screen_entered)


func _process(delta: float) -> void:
	if Input.is_action_pressed("select_element"):
		contraction_controller.soothe_contraction(delta*0.1)
		
		if contraction_controller._check_soothed() :
			#HACKs
			process_mode = Node.PROCESS_MODE_DISABLED
			contraction_controller.stop_contraction()
			SignalManager.show_next_button.emit()

func _on_screen_entered():
	contraction_controller.trigger_contraction()	
